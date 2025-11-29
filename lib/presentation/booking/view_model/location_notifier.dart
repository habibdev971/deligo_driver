import 'dart:async';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';
import 'package:deligo_driver/presentation/booking/provider/ride_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:deligo_driver/presentation/booking/provider/home_providers.dart';

import '../../../data/repositories/interfaces/i_geo_location_manager.dart';
import '../provider/way_point_list_provider.dart';

class LocationState {
  final bool isFirstEvent;
  final bool isOnUpdateActive;

  LocationState({
    required this.isFirstEvent,
    this.isOnUpdateActive = false,
  });

  LocationState copyWith({
    bool? isFirstEvent,
    bool? isOnUpdateActive,
  }) => LocationState(
      isFirstEvent: isFirstEvent ?? this.isFirstEvent,
      isOnUpdateActive: isOnUpdateActive ?? this.isOnUpdateActive,
    );
}


class LocationNotifier extends StateNotifier<LocationState> {
  final IGeoLocationManager _geoManager;
  final Ref ref;
  StreamSubscription<LatLng>? _locationSubscription;

  LatLng? _lastSentLatLng;
  DateTime _lastSentTime = DateTime.now().subtract(const Duration(seconds: 10));
  Function(LatLng)? _onNewLocation;

  LocationNotifier(this._geoManager, this.ref)
      : super(LocationState(isFirstEvent: true));

  void startTracking({Function(LatLng)? onUpdate}) async {
    _onNewLocation = onUpdate;

    final hasPermission = await _geoManager.checkLocationPermission();
    if (!hasPermission) return;

    _locationSubscription?.cancel();

    _locationSubscription = _geoManager.locationStream().listen((latLng) {
      ref.read(bookingNotifierProvider.notifier).updateLocationMarker(latLng);
      // if(ref.watch(driverStatusNotifierProvider).whenOrNull(onTrip: ()=> true) ?? false){
      //
      // }

      final now = DateTime.now();

      final double distance = _lastSentLatLng == null
          ? 0
          : _calculateDistance(_lastSentLatLng!, latLng);

      // final bool movedSignificantly = _lastSentLatLng == null || distance > 25; //15
      // final bool enoughTimePassed = now.difference(_lastSentTime).inSeconds >= 7; //5
      final bool movedSignificantly = true;
      final bool enoughTimePassed = true;

      if (state.isFirstEvent) {
        _lastSentTime = now;
        _lastSentLatLng = latLng;
        saveDriverLocations(latLng);

        if (state.isOnUpdateActive) {
          _onNewLocation?.call(latLng);
        }

        state = LocationState(
          isFirstEvent: false,
          isOnUpdateActive: state.isOnUpdateActive,
        );
        return;
      }

      if (movedSignificantly && enoughTimePassed) {
        _lastSentTime = now;
        _lastSentLatLng = latLng;
        saveDriverLocations(latLng);
        ref.read(rideDetailsProvider).whenOrNull(success: (data){
          final String? status = data?.status;
          debugPrint('current status: $status');
          if(status == 'END' || status == 'CANCELLED' || status == 'REJECTED' || status == 'COMPLETED'){

          }else{
            ref
                .read(routeNotifierProvider.notifier)
                .fetchRoutesDetail(
              data?.points,
              // sendDataToRider: mode == MovementMode.towardsDestination,
              // pickUpPoint: pickupLatLng,
              current: latLng,
              orderId: data?.id,
            );
          }


        });
        if (state.isOnUpdateActive) {
          _onNewLocation?.call(latLng);
        }
      }
    });
  }

  void enableOnUpdateCallback() {
    state = state.copyWith(isFirstEvent: true, isOnUpdateActive: true);
  }

  void disableOnUpdateCallback() {
    state = state.copyWith(isOnUpdateActive: false);
  }

  void stopTracking() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
    state = state.copyWith(isFirstEvent: true, isOnUpdateActive: false);
  }

  Future<void> saveDriverLocations(LatLng latLng) async {
    final results = await Connectivity().checkConnectivity();

    // এখন results হলো List<ConnectivityResult>
    final hasInternet = results.any((result) => result != ConnectivityResult.none);
    final String? token = await LocalStorageService().getToken();
    if (token == null) return;
    if (!hasInternet) return;

    try {
      await _geoManager.saveDriverLocation(latLng, ref: ref);
    } catch (e, st) {
      debugPrint('Error saving driver location: $e');
    }
  }

  double _calculateDistance(LatLng from, LatLng to) {
    const double earthRadius = 6371000;
    final double dLat = _deg2rad(to.latitude - from.latitude);
    final double dLon = _deg2rad(to.longitude - from.longitude);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(from.latitude)) *
            cos(_deg2rad(to.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _deg2rad(double deg) => deg * (pi / 180);

  @override
  void dispose() {
    stopTracking();
    super.dispose();
  }
}
