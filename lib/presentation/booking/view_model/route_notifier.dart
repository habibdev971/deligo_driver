import 'dart:math';

import 'package:deligo_driver/presentation/booking/provider/ride_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:deligo_driver/core/errors/failure.dart';
import 'package:deligo_driver/core/state/app_state.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/data/models/common_response.dart';
import 'package:deligo_driver/data/models/order_response/order_model/points/points.dart';
import 'package:deligo_driver/data/models/route_info_model.dart';
import 'package:deligo_driver/presentation/booking/provider/home_providers.dart';
import '../../../data/repositories/interfaces/way_points_repo_interface.dart';
import '../provider/way_point_list_provider.dart';

class RouteNotifier extends StateNotifier<AppState<RouteInfo>> {
  final IGoogleAPIRepo googleAPIRepo;
  final Ref ref;

  RouteNotifier({required this.ref, required this.googleAPIRepo})
    : super(const AppState.initial());

  Future<void> fetchRoutesDetail(
    Points? points, {
    // LatLng? pickUpPoint,
    LatLng? current,
    required num? orderId,
  }) async {
    List<num>? destination = points?.dropLocation;
    final List<num> origin = [current?.latitude ?? 0, current?.longitude ?? 0];

    final rideState = ref.watch(rideDetailsProvider);
    final String? rideStatus = rideState.whenOrNull(
      success: (data) => data?.status,
    );
    final bool isLoading =
        rideState.whenOrNull(loading: () => true, error: (e) => true) ?? false;
    if (isLoading) return;
    if (rideStatus == 'GO_TO_PICKUP' || rideStatus == 'ACCEPTED' || rideStatus == 'ACCEPT') {
      destination = points?.pickupLocation;
    } else if (rideStatus == 'DROPPED_OFF' ||
        rideStatus == 'END' ||
        rideStatus == 'COMPLETED') {
      return;
    }
    // else if(rideStatus == 'ACCEPTED'){
    //   origin = points?.pickupLocation;
    //   destination = points?.dropLocation;
    // }
    state = const AppState.loading();
    final result = await googleAPIRepo.fetchWayPoints(
      waypoints: Points(pickupLocation: origin, dropLocation: destination),
    );
    result.fold(
      (error) {
        state = AppState.error(error);
      },
      (v) {
        if (v.polylinePoints.length < 2) {
          return state = AppState.error(Failure(message: 'Invalid route data'));
        }

        final polyLine = {
          Polyline(
            polylineId: const PolylineId('route'),
            color: ColorPalette.primary50,
            width: 5,
            points: v.polylinePoints,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
          ),
        };

        // final pickup = pickUpPoint;
        final lat = (points?.pickupLocation?.firstOrNull)?.toDouble();
        final lng = (points?.pickupLocation?.lastOrNull)?.toDouble();

        final latD = (points?.dropLocation?.firstOrNull)?.toDouble();
        final lngD = (points?.dropLocation?.lastOrNull)?.toDouble();
        // final current =
        //     (lat != null && lng != null) ? LatLng(lat, lng) : null;
        final destination = (latD != null && lngD != null)
            ? LatLng(latD, lngD)
            : null;
        final pickUp = (lat != null && lng != null) ? LatLng(lat, lng) : null;

        final totalDistance = v.distanceInMeters;
        final polyline = v.polylinePoints;

        calculateRouteProgress(
          ref,
          startProgress: !(rideStatus == 'ARRIVED' || rideStatus == 'GO_TO_PICKUP' || rideStatus == 'ACCEPTED' || rideStatus == 'ACCEPT'),
          orderId: int.tryParse(orderId.toString()),
          pickup: pickUp,
          current: current,
          totalDistanceInMeters: totalDistance,
          polylinePoints: polyline,
          routeInfo: v,
          destination: destination,
        );

        ref.read(bookingNotifierProvider.notifier).updatePolyLines(polyLine);
        state = AppState.success(v);
      },
    );
  }
}

class SendTravelInfoNotifier extends StateNotifier<AppState<CommonResponse>> {
  final IGoogleAPIRepo googleAPIRepo;
  final Ref ref;
  SendTravelInfoNotifier({required this.ref, required this.googleAPIRepo})
    : super(const AppState.initial());

  Future<void> sendTravelInfo({required Map<String, dynamic> info}) async {
    final result = await googleAPIRepo.sendTravelInfo(info: info);

    result.fold(
      (error) {
        state = AppState.error(error);
        // showNotification(message: error.message);
      },
      (v) {
        debugPrint('-------------travel info send successfully');
        state = AppState.success(v);
      },
    );
  }
}

double calculateHaversineDistance(LatLng start, LatLng end) {
  const R = 6371000; // Earth's radius in meters
  final dLat = _toRadians(end.latitude - start.latitude);
  final dLng = _toRadians(end.longitude - start.longitude);

  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_toRadians(start.latitude)) *
          cos(_toRadians(end.latitude)) *
          sin(dLng / 2) *
          sin(dLng / 2);

  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c;
}

double _toRadians(double degree) => degree * pi / 180;

/// Calculate route progress between pickup -> current based on total distance.
/// Returns progress [0.0 - 1.0]. If any input is null or invalid, returns 0.0.
Future<void> calculateRouteProgress(
  Ref ref, {
    bool startProgress = false,
  required int? orderId,
  required LatLng? pickup,
  required LatLng? current,
  required int? totalDistanceInMeters,
  required List<LatLng>? polylinePoints,
  required RouteInfo routeInfo,
  required LatLng? destination,
}) async {
  if (pickup == null ||
      current == null ||
      destination == null ||
      totalDistanceInMeters == null ||
      totalDistanceInMeters <= 0) {
    return;
  }

  final distanceTravelled = startProgress ? calculateHaversineDistance(pickup, destination) : 0;
  final progress = startProgress ? (distanceTravelled / totalDistanceInMeters).clamp(0.0, 1.0) : 0.0;
  ref.read(routeProgressProvider.notifier).state = startProgress ? progress : 0;
  ref
      .read(sendTravelInfoProvider.notifier)
      .sendTravelInfo(
        info: {
          'order_id': orderId,
          'minute': formatDurationSeconds(routeInfo.durationInSeconds),
          'distance': routeInfo.distanceText,
          'progress': progress,
          'destination': destination,
          'driver_location': current,
          'polyline': polylinePoints,
          // 'polyline': routeInfo.polylinePoints,
        },
      );
}

String formatDurationSeconds(int totalSeconds) {
  if (totalSeconds == 0) return 'Reached';

  final int days = totalSeconds ~/ 86400;
  totalSeconds %= 86400;

  final int hours = totalSeconds ~/ 3600;
  totalSeconds %= 3600;

  final int minutes = totalSeconds ~/ 60;
  final int seconds = totalSeconds % 60;

  final List<String> parts = [];

  String plural(int value, String unit) =>
      value == 1 ? '$value $unit' : '$value ${unit}s';

  if (days > 0) parts.add(plural(days, 'day'));
  if (hours > 0) parts.add(plural(hours, 'hour'));

  if (minutes > 0) {
    parts.add("${minutes.toString().padLeft(2, '0')} min");
  }

  if (seconds > 0) parts.add(plural(seconds, 'second'));

  return parts.isEmpty ? 'Reached' : parts.join(', ');
}
