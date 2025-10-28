import 'package:deligo_driver/presentation/booking/provider/save_order_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/enums/booking_status.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/data/models/order_response/order_model/order/order.dart';
import 'package:deligo_driver/gen/assets.gen.dart';
import 'package:deligo_driver/presentation/booking/provider/cancel_ride_provider.dart';
import 'package:deligo_driver/presentation/booking/provider/driver_providers.dart';
import 'package:deligo_driver/presentation/booking/widgets/trip_cards/action_sheet.dart';
import 'package:deligo_driver/presentation/home_page/widgets/rider_details.dart';
import 'package:deligo_driver/presentation/home_page/widgets/location_time_calculated.dart';

import '../../provider/cancel_button_provider.dart';
import '../../provider/ride_providers.dart';

Widget confirmPickup(BuildContext context, Order? order) => Consumer(
  builder: (context, ref, _) {
    final rideOrderNotifier = ref.read(saveOrderStatusProvider.notifier);
    final rideOrderState = ref.read(saveOrderStatusProvider);
    final onTripNotifier = ref.read(onTripStatusProvider.notifier);
    final timerState = ref.watch(cancelButtonEnableTimerProvider);
    final timerStateNotifier = ref.read(
      cancelButtonEnableTimerProvider.notifier,
    );
    final cancelProvider = ref.read(cancelRideNotifierProvider.notifier);

    return actionSheet(
      context,
      riderInfo: riderDetails(context, order?.rider),
      locationTime: locationTime(context),
      title: localize(context).pickup_rider,
      description: localize(context).double_check_rider,
      image: Assets.images.confirmPickup.image(
        height: 130.h,
        width: 194.w,
        fit: BoxFit.fill,
      ),
      actions: [
        Expanded(
          child: AppPrimaryButton(
            isLoading:
                ref
                    .read(cancelRideNotifierProvider)
                    .whenOrNull(loading: () => true) ??
                false,
            isDisabled: !timerState.isButtonEnabled,
            onPressed: () {
              cancelProvider.cancelRide();
            },
            child: Text(
              localize(context).cancel_ride,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Gap(16.w),
        Expanded(
          child: AppPrimaryButton(
            // isLoading: rideOrderState.whenOrNull(loading: () => true) ?? false,
            onPressed: () {
              rideOrderNotifier.saveOrderStatus(
                status: 'DROPPED_OFF',
                onSuccess: (v) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    onTripNotifier.updateOnTripStatus(
                      status: BookingStatus.rideStarted,
                    );
                    timerStateNotifier.cancelTimer();
                  });
                },
              );
            },
            child: Text(
              localize(context).confirm_pickup,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium?.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  },
);
