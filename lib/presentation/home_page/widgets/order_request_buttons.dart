import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/presentation/booking/provider/ride_providers.dart';

import '../../../core/enums/booking_status.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/services/local_storage_service.dart';
import '../../../data/services/pusher_service.dart';
import '../../booking/provider/driver_providers.dart';

Widget orderRequestButtons(BuildContext context, {num? orderId})=> Consumer(
    builder: (context, ref, _) {
      final driverStatusNotifier = ref.watch(driverStatusNotifierProvider.notifier);
      final onTripStatusNotifier = ref.watch(ontripStatusNotifier.notifier);
      final orderStatusNotifier = ref.read(rideOrderNotifierProvider.notifier);
      final orderStatusState = ref.watch(rideOrderNotifierProvider);
      final bool isLoading = orderStatusState.whenOrNull(loading: ()=> true) ?? false;
      return Row(
        children: [
          Expanded(child: AppPrimaryButton(
            isLoading: isLoading,
              isDisabled: isLoading,
              backgroundColor: const Color(0xFFF6F7F9),
              onPressed: (){
                orderStatusNotifier.saveOrderStatus(status: 'rejected', onError: (failure)async{
                  if(failure.code == 422){
                    await LocalStorageService().clearOrderId();
                    driverStatusNotifier.online();
                    NavigationService.pop();
                  }
                }, onSuccess: (data)async{
                  await LocalStorageService().clearOrderId();
                  driverStatusNotifier.online();
                  NavigationService.pop();
                });
                }, child: Text(localize(context).cancel, style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: isDarkMode() ? Colors.white : const Color(0xFF24262D)),))),
          Gap(16.w),
          Expanded(child: AppPrimaryButton(onPressed: (){
             orderStatusNotifier.saveOrderStatus(
              status: 'accepted',
               onSuccess: (data)async{
                 driverStatusNotifier.onTrip();
                 onTripStatusNotifier.updateOnTripStatus(status: BookingStatus.goForPickup,);
                 NavigationService.pushNamed(AppRoutes.bookingPage);
                 final userId = await LocalStorageService().getUserId();
                 PusherService().subscribeChannel('chat_$userId');
               }
            );
          }, child: Text(localize(context).accept_ride, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),))),
        ],
      );
    }
  );