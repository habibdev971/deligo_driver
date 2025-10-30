import 'package:deligo_driver/core/state/app_state.dart';
import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/data/models/common_response.dart';
import 'package:deligo_driver/data/models/ride_details_model/RideDetailsModel.dart';
import 'package:deligo_driver/data/repositories/interfaces/ride_repo_interface.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routes/app_routes.dart';
import '../../../data/models/request_accept_model/OrderAcceptModel.dart';
import '../provider/ride_providers.dart';

class AcceptRejectNotifier extends StateNotifier<AppState<OrderAcceptModel>>{
  final Ref ref;
  final IRideRepo repo;
  AcceptRejectNotifier({required this.ref, required this.repo}):super(const AppState.initial());
  String status = '';
  Future<void> acceptRide({required int orderId, Function? onSuccess})async{
    status = 'accept';
    state = const AppState.loading();
    final res = await repo.acceptRejectRide(orderId: orderId, status: 'accept');
    res.fold(
            (l) {
              state = AppState.error(l);
              showNotification(message: l.message);
            },
            (r) async{
              state = AppState.success(r);
              await LocalStorageService().saveRideId(num.tryParse(r.data?.rides?.id ?? ''));
              showNotification(message: r.message, isSuccess: true);
              NavigationService.pushNamed(AppRoutes.bookingPage);
              await ref.read(rideDetailsProvider.notifier).getRideDetails(orderId);
              onSuccess != null ? onSuccess() : null;
            });
    status = '';

  }

  Future<void> rejectRide({required int orderId})async{
    status = 'reject';
    state = const AppState.loading();
    final res = await repo.acceptRejectRide(orderId: orderId, status: 'reject');
    res.fold(
            (l) {
              state = AppState.error(l);
              showNotification(message: l.message);
              NavigationService.pop();
            },
            (r) {
              state = AppState.success(r);
              showNotification(message: r.message, isSuccess: true);
              NavigationService.pop();
            });
    status = '';
  }
}


class RideDetailsNotifier extends StateNotifier<AppState<RideRequest?>>{
  final Ref ref;
  final IRideRepo repo;
  RideDetailsNotifier({required this.ref, required this.repo}):super(const AppState.initial());

  Future<void> getRideDetails(int? orderId)async{
    state = const AppState.loading();
    final res = await repo.rideDetail(orderId: orderId);
    res.fold(
            (l) => state = AppState.error(l),
            (r) => state = AppState.success(r.data?.rideRequest ));

  }
}

class SaveOrderStatusNotifier extends StateNotifier<AppState<CommonResponse>>{
  final Ref ref;
  final IRideRepo repo;
  SaveOrderStatusNotifier({required this.ref, required this.repo}):super(const AppState.initial());

  Future<void> saveOrderStatus({required String status, Function? onSuccess})async{
    state = const AppState.loading();
    final orderId = await LocalStorageService().getRideId();
    final res = await repo.saveOrderStatus(orderId: orderId, status: status, sendOtherData: status.contains('END'));
    res.fold(
            (l) {
              state = AppState.error(l);
              showNotification(message: l.message);
            },
            (r) {
              state = AppState.success(r);
              showNotification(message: r.message, isSuccess: true);
              onSuccess != null ? onSuccess(r) : null;
            });
  }
}