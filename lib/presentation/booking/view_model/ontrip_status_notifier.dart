import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/core/enums/booking_status.dart';
import 'package:deligo_driver/core/enums/movements.dart';
import 'package:deligo_driver/core/state/on_trip_status.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';
import 'package:deligo_driver/data/services/pusher_service.dart';

import '../provider/home_providers.dart';

class OnTripStatusNotifier extends StateNotifier<OnTripStatusState> {
  final Ref ref;
  OnTripStatusNotifier(this.ref) : super(const OnTripStatusState.goForPickup());

  final local = LocalStorageService();

  Future<void> updateOnTripStatus({
    required BookingStatus status,
    bool fromSplash = false,
  }) async{
    final bookingNotifier =  ref.read(bookingNotifierProvider.notifier);
    await bookingNotifier.setCurrentLocation();
    switch (status) {
      case BookingStatus.initial:
        state = const OnTripStatusState.initial();
        break;
      case BookingStatus.goForPickup:
        state = const OnTripStatusState.goForPickup();
        // PusherService().subscribeChannel('order.${await local.getRequestId()}.${await local.getUserId()}');
        bookingNotifier.updateMarkerForOrder(mode: MovementMode.orderAccept);

        break;
      case BookingStatus.arrivedAtPickupPoint:
        state = const OnTripStatusState.arrivedAtPickupPoint();
        bookingNotifier.updateMarkerForTowardsPickup();

        break;
      // case BookingStatus.pickupConfirmed:
      //   state = const OnTripStatusState.pickupConfirmed();
      //     bookingNotifier.updateMarkerForOrder(mode: MovementMode.towardsPickup);
      //   bookingNotifier.stopLocationUpdates();
      //
      //   break;
      case BookingStatus.rideStarted:
        state = const OnTripStatusState.rideStarted();
        if(fromSplash){
          bookingNotifier.updateMarkerForTowardsPickup();
        }
        bookingNotifier.stopLocationUpdates();
        break;

      case BookingStatus.headingToDestination:
        state = const OnTripStatusState.headingToDestination();
        bookingNotifier.updateMarkerForTowardsDestination();
        break;

      case BookingStatus.reachedDestination:
        state = const OnTripStatusState.reachedDestination();
        if(fromSplash){
          bookingNotifier.updateMarkerForOrder(mode: MovementMode.orderAccept);
        }
          bookingNotifier.stopLocationUpdates();
        await local.saveChatState(isOpen: false);

        break;
      case BookingStatus.payment:
          state = const OnTripStatusState.payment();
          ref.read(bookingNotifierProvider.notifier).resetPolyLines();
          ref.read(bookingNotifierProvider.notifier).resetMarker();
          ref.read(bookingNotifierProvider.notifier).stopLocationUpdates();

    }
  }

  OnTripStatusState? _previousState;

  // void goToChat() async{
  //   _previousState = state;
  //   state = const OnTripStatusState.chat();
  //   await local.saveChatState(isOpen: true);
  // }
  //
  // void hideChat() async{
  //   if (_previousState != null) {
  //     state = _previousState!;
  //     _previousState = null;
  //   } else {
  //     state = const OnTripStatusState.initial();
  //   }
  //   await local.saveChatState(isOpen: false);
  // }

  void resetState() {
    state = const OnTripStatusState.goForPickup();
  }
}
