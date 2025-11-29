import 'package:deligo_driver/data/models/ride_details_model/RideDetailsModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/core/errors/failure.dart';
import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/data/repositories/interfaces/ride_repo_interface.dart';
import '../../../core/state/app_state.dart';
import '../../../data/models/order_response/order_model/order/order.dart';
import '../../../data/models/order_response/pusher_order/PusherRequestOrderModel.dart';
import '../../../data/services/local_storage_service.dart';
import '../../home_page/widgets/order_request_dialogue.dart';
import '../../splash/provider/app_flow_providers.dart';

class RideOrderNotifier extends StateNotifier<AppState<RideRequest?>> {
  final IRideRepo rideRepo;
  final Ref ref;

  RideOrderNotifier({
    required this.ref,
    required this.rideRepo,
  }) : super(const AppState.initial());

  Future<void> orderDetails({required int orderId}) async {
    // final previousData = _getPreviousDataOrNull();
    // state = previousData != null
    //     ? AppStateOrder.success(previousData)
        state = const AppState.loading();

    final result = await rideRepo.orderDetails(orderId: orderId);

    result.fold(
          (failure) {
        showNotification(message: failure.message);
        // Future.delayed(const Duration(milliseconds: 600)).then((_) {
        //   ref.read(driverStatusNotifierProvider.notifier).online();
        // });
        // state unchanged → previous success data shown
      },
          (data) async{
        state = AppState.success(data.data?.rideRequest);
        // final PusherRequestOrderModel model = ;
        final rideRequest = data.data?.rideRequest;
        final user = rideRequest?.rider;
        await LocalStorageService().saveRequestId(orderId.toInt());
        orderRequestDialogue(
            ref: ref,
            data: PusherRequestOrderModel(
          rideRequestId: rideRequest?.id,
          serviceTypeId: rideRequest?.serviceTypeId,
          scheduledAt: rideRequest?.scheduledAt,
          distance: rideRequest?.distance,
          estimatedFare: rideRequest?.estimatedFare,
          estimatedTime: rideRequest?.estimatedTime,
          distanceFromDriver: rideRequest?.actualDistance,
          userId: user?.id,
          user: User(
            id: user?.id,
            fullName: user?.name,
            userInfo: UserInfo(
              picture: user?.profilePicture,
              rattings: user?.rating,
            )
          ),
          pickupLocation: PickupLocation(
            address: rideRequest?.addresses?.pickupAddress,
            // latitude: (rideRequest?.points?.pickupLocation?.first ?? 0),
            // longitude: rideRequest?.pickupLongitude,
          ),
          dropoffLocation: DropoffLocation(
            address: rideRequest?.addresses?.dropAddress
          ),

        ));
      },
    );
  }

  // String currentStatus = '';
  // Future<void> saveOrderStatus({
  //   required String status,
  //   Function(Order? data)? onSuccess,
  //   Function(Failure data)? onError,
  // }) async {
  //   currentStatus = status;
  //   final loadingNotifier = ref.read(loadingProvider.notifier)
  //     ..startLoading();
  //   final previousData = _getPreviousDataOrNull();
  //   state = previousData != null
  //       ? AppStateOrder.success(previousData)
  //       : const AppStateOrder.loading();
  //
  //   final result = await rideRepo.saveRideStatus(
  //     orderId: await LocalStorageService().getRequestId() ?? 0,
  //     status: status,
  //   );
  //
  //   result.fold(
  //         (failure) {
  //       showNotification(message: failure.message);
  //       onError != null ? onError(failure) : null;
  //       // if(failure.code == 422){
  //       //   NavigationService.pop();
  //       // }
  //       // state unchanged → keep previous UI
  //     },
  //         (data) {
  //           showNotification(message: data.message, isSuccess: true);
  //       state = AppStateOrder.success(data.data);
  //       if (onSuccess != null) {
  //         onSuccess(data.data);
  //       }
  //     },
  //   );
  //   loadingNotifier.stopLoading();
  //   currentStatus = '';
  // }
  //
  // Future<void> setOrderData(Order order) async {
  //   await LocalStorageService().saveRequestId(order.id);
  //   state = AppStateOrder.success(order);
  // }
  //
  // void navigateToHome() {
  //   LocalStorageService()
  //   .clearOrderId();
  //
  //   ref.read(bookingNotifierProvider.notifier)
  //   ..stopLocationUpdates()
  //   ..resetToInitial();
  // }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.loading();
    });
  }


  // Order? _getPreviousDataOrNull() => state.maybeWhen(
  //     success: (data) => data,
  //     orElse: () => null,
  //   );
}


class CheckTripActivityNotifier extends StateNotifier<AppState<Order?>> {
  final IRideRepo rideRepo;
  final Ref ref;

  CheckTripActivityNotifier(this.rideRepo, this.ref)
      : super(const AppState.initial());
  Future<void> checkTripActivity({Function()? onSuccess}) async {
    final String? token = await LocalStorageService().getToken();
    if(token != null){
      state = const AppState.loading();
      final result = await rideRepo.checkActiveTrip();
      result.fold(
            (failure) => _handleFailure(failure),
            (data) {
          if(data.data?.order != null){
            state = AppState.success(data.data!.order);
            // ref.read(rideOrderNotifierProvider.notifier).setOrderData(data.data!.order!);
          }else{
            state = const AppState.success(null);
          }
          if(onSuccess != null){
            onSuccess();
          }
        },
      );
    }
    ref.read(appFlowViewModelProvider.notifier).setAppFlowState();
  }

  void _handleFailure(Failure failure) {
    state = AppState.error(failure);
    showNotification(
      message: failure.message,
    );
  }

}
