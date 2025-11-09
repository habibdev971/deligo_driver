import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/data/models/ride_details_model/RideDetailsModel.dart';
import 'package:deligo_driver/presentation/booking/provider/save_order_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deligo_driver/core/enums/booking_status.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/gen/assets.gen.dart';
import 'package:deligo_driver/presentation/booking/provider/driver_providers.dart';
import 'package:deligo_driver/presentation/booking/widgets/trip_cards/action_sheet.dart';
import 'package:deligo_driver/presentation/home_page/widgets/rider_details.dart';
import 'package:deligo_driver/presentation/home_page/widgets/location_time_calculated.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/localize.dart';
import '../../provider/cancel_button_provider.dart';
import '../../provider/cancel_ride_provider.dart';

Widget rideStarted(BuildContext context, RideRequest? order) => Consumer(
  builder: (context, ref, _) {
    final rideOrderNotifier = ref.read(saveOrderStatusProvider.notifier);
    final orderLoading = ref.watch(saveOrderStatusProvider).whenOrNull(loading: () => true) ?? false;
    final onTripNotifier = ref.read(onTripStatusProvider.notifier);
    // final timerState = ref.watch(cancelButtonEnableTimerProvider);
    // final timerStateNotifier = ref.read(
    //   cancelButtonEnableTimerProvider.notifier,
    // );
    final cancelProvider = ref.read(cancelRideNotifierProvider.notifier);
    final cancelLoading = ref.watch(cancelRideNotifierProvider).whenOrNull(loading: () => true) ?? false;
    return actionSheet(
      context,
      riderInfo: riderDetails(context, order?.rider),
      locationTime: locationTime(context),
      title: localize(context).all_set_start_ride,
      description: localize(context).start_journey_navigation,
      image: Assets.images.startRide.image(
        height: 130.h,
        width: 194.w,
        fit: BoxFit.fill,
      ),
      actions: [
        Expanded(
          child: AppPrimaryButton(
            isLoading:
                cancelLoading,
            // isDisabled: !timerState.isButtonEnabled,
            isDisabled: orderLoading,
            // onPressed: () {
            //   timerStateNotifier.startTimer();
            // },),
            backgroundColor: Colors.red,
            onPressed: () {
              // showNotification(message: "Working on it");
              cancelProvider.cancelRide(orderId: order?.id);
            },
            child: Text(
              localize(context).cancel_ride,
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
        Gap(16.w),
        Expanded(
          child: AppPrimaryButton(
            isLoading: orderLoading,
            isDisabled: cancelLoading,
            onPressed: () {
              rideOrderNotifier.saveOrderStatus(
                status: 'START',
                onSuccess: (v) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    onTripNotifier.updateOnTripStatus(
                      status: BookingStatus.headingToDestination,
                    );
                  });
                },
              );
            },
            child: Text(
              localize(context).tap_to_start_ride,
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
