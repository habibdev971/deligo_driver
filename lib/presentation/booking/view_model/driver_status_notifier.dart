import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/core/state/app_state.dart';
import 'package:deligo_driver/core/state/driver_status_state.dart';
import 'package:deligo_driver/data/models/driver_radius_update_response/driver_radius_update_response.dart';
import 'package:deligo_driver/data/repositories/interfaces/status_repo_interface.dart';
import 'package:deligo_driver/presentation/home_page/widgets/order_request_dialogue.dart';

import '../../../data/services/local_storage_service.dart';
import '../../home_page/widgets/online_offline_switch.dart';
import '../provider/home_providers.dart';
import '../provider/location_provider.dart';
import '../provider/pusher_provider.dart';
import '../provider/ride_providers.dart';

class DriverStatusNotifier extends StateNotifier<DriverStatusState> {
  final IStatusRepo statusRepo;
  final Ref ref;
  DriverStatusNotifier(this.ref, this.statusRepo) : super(const DriverStatusState.initial()) {
    initialize();
  }


  void initialize() async{
    await LocalStorageService().getOnlineOffline() ? online() : offline();
  }

  void onTrip() {
    state = const DriverStatusState.onTrip();
  }


  void offline() {
    state = const DriverStatusState.offline();
    isOnlineNotifier.value = false;
    ref.read(pusherNotifierProvider.notifier).disconnect();
  }

  void online() {

    ref.read(pusherNotifierProvider.notifier).setupPusherListeners();
    state = const DriverStatusState.online();
    isOnlineNotifier.value = true;
  }

  // Future<void> orderRequest({required Map<String, dynamic> data}) async{
  //
  //   orderRequestDialogue();
  //   // await ref.read(rideOrderNotifierProvider.notifier).orderDetails(orderId: data['order_id']);
  //   ref.read(bookingNotifierProvider.notifier).updateMapZoom();
  //
  //   state = DriverStatusState.orderRequest(data);
  //
  // }

  Future<void> updateOnlineStatus(bool status) async {
    state = DriverStatusState.loading();
    final result = await statusRepo.updateOnlineStatus(status: status);
    result.fold(
          (failure) => state = const DriverStatusState.offline(),
          (data) async{
        if (data.data?.serviceStatus == false) {
          await LocalStorageService().setOnlineOffline();
          isOnlineNotifier.value = false;
          ref.read(pusherNotifierProvider.notifier).disconnect();
          WidgetsBinding.instance.addPostFrameCallback((v) async{
            ref.read(bookingNotifierProvider.notifier).resetToInitial(enablePusher: false);
            ref.read(bookingNotifierProvider.notifier).resetMapZoom();
            ref.read(locationNotifierProvider.notifier).stopTracking();

          });
          state = const DriverStatusState.offline();
        } else {
          isOnlineNotifier.value = true;
          state = const DriverStatusState.online();
          ref.read(pusherNotifierProvider.notifier).setupPusherListeners();
          ref.read(locationNotifierProvider.notifier).startTracking();
          await LocalStorageService().setOnlineOffline(true);
        }
      },
    );
  }
}

class DriverRadiusNotifier extends StateNotifier<AppState<DriverRadiusUpdateResponse>> {
  final IStatusRepo statusRepo;
  final Ref ref;
  DriverRadiusNotifier(this.ref, this.statusRepo) : super(const AppState.initial());

  Future<void> updateRadius(int radius) async {
    state = const AppState.loading();
    final result = await statusRepo.updateRadius(radius: radius);
    result.fold(
      (failure) => state = AppState.error(failure),
      (data) async{
         await LocalStorageService().saveUser(data: data.data?.user?.toJson());
        state = AppState.success(data);
      },
    );
  }
}

