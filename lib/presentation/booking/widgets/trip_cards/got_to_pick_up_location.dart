// import 'package:deligo_driver/data/models/order_response/order_model/rider/rider.dart' as r;
import 'package:deligo_driver/data/models/ride_details_model/RideDetailsModel.dart';
import 'package:deligo_driver/presentation/booking/provider/save_order_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deligo_driver/core/enums/booking_status.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/data/models/order_response/order_model/order/order.dart' as r;
import 'package:deligo_driver/gen/assets.gen.dart';
import 'package:deligo_driver/presentation/booking/provider/driver_providers.dart';
import 'package:deligo_driver/presentation/booking/widgets/trip_cards/action_sheet.dart';
import 'package:deligo_driver/presentation/home_page/widgets/rider_details.dart';

import '../../provider/ride_providers.dart';

Widget gotoPickupLocation(BuildContext context, RideRequest? order) => Consumer(
  builder: (context, ref, _) {
    final rideOrderNotifier = ref.read(saveOrderStatusProvider.notifier);
    final rideOrderState = ref.watch(saveOrderStatusProvider);
    final onTripNotifier = ref.read(onTripStatusProvider.notifier);
    final riderData = ref.watch(rideDetailsProvider).whenOrNull(success: (data)=> data?.rider);


    return actionSheet(
      context,
      riderInfo: riderDetails(
        context,
        riderData
        // r.Order.Rider(
        //   id: riderData?.id,
        //   name: riderData?.name,
        //   mobile: riderData?.mobile,
        //   email: riderData?.email,
        //   profilePicture: riderData?.profilePicture,
        //   rating: riderData?.rating
        // )
        // rideOrderState.whenOrNull(success: (order) => order?.rider),
      ),
      title: localize(context).rider_waiting_move_now,
      description: localize(context).time_to_pickup,
      image: Assets.images.goToPickUpLocation.image(
        height: 134.h,
        width: 232.w,
        fit: BoxFit.fill,
      ),
      actions: [
        Expanded(
          child: AppPrimaryButton(
            isLoading: rideOrderState.whenOrNull(loading: () => true) ?? false || (ref.watch(rideDetailsProvider).whenOrNull(loading: ()=> true) ?? false),
            onPressed: () {
              rideOrderNotifier.saveOrderStatus(

                status: 'GOTO_PICKUP',
                onSuccess: (v) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    onTripNotifier.updateOnTripStatus(
                      status: BookingStatus.arrivedAtPickupPoint,
                    );
                  });
                },
              );
            },
            child: Text(
              localize(context).go_to_pickup_location,
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
