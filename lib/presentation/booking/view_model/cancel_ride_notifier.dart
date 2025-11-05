import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/core/routes/app_routes.dart';
import 'package:deligo_driver/core/state/app_state.dart';
import 'package:deligo_driver/data/models/common_response.dart';
import 'package:deligo_driver/data/repositories/interfaces/cancel_ride_repo_interface.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/presentation/booking/provider/home_providers.dart';

import '../../../core/utils/helpers.dart';
import '../../../data/services/local_storage_service.dart';

class CancelRideNotifier extends StateNotifier<AppState<CommonResponse>> {
  final ICancelRideRepo rideRepo;
  final Ref ref;
  CancelRideNotifier(this.ref, this.rideRepo) : super(const AppState.initial());

  Future<void> cancelRide() async {
    final local = LocalStorageService();
    state = const AppState.loading();

    final orderId = await local.getRideId();

    final result = await rideRepo.cancelRide(orderId: orderId?.toInt());

    result.fold(
          (failure) {
        state = AppState.error(failure);

        showNotification(
          message: failure.message,
        );
      },
          (data) {
        final message = data.message ?? 'Ride cancelled';

        showNotification(
          message: message,
        );

          state = AppState.success(data);

          local.clearOrderId();
          ref.read(bookingNotifierProvider.notifier).resetToInitial();
          NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);


      },
    );
  }


}