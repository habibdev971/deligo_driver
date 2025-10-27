import 'package:deligo_driver/data/models/order_response/order_model/address/address.dart';
import 'package:deligo_driver/data/models/order_response/order_model/rider/rider.dart';
import 'package:deligo_driver/data/models/order_response/pusher_order/PusherRequestOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/show_global_dialogue.dart';
import 'package:deligo_driver/presentation/home_page/widgets/rider_details.dart';
import 'package:deligo_driver/presentation/home_page/widgets/location_time_calculated.dart';
import 'package:deligo_driver/presentation/home_page/widgets/order_request_buttons.dart';
import 'package:deligo_driver/presentation/home_page/widgets/readable_location_view.dart';

void orderRequestDialogue({PusherRequestOrderModel? data}) {
  showGlobalAlertDialog(
    child: _OrderRequestDialog(data: data,),
  );
}

class _OrderRequestDialog extends ConsumerWidget {
  final PusherRequestOrderModel? data;
  const _OrderRequestDialog({this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r), side: isDarkMode() ? const BorderSide(color: Colors.white) : BorderSide.none),
      insetPadding: EdgeInsets.all(16.r),
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // even spacing
            children: [
              riderDetails(context, Rider(
                id: data?.user?.id,
                name: data?.user?.fullName,
                profilePicture: data?.user?.userInfo?.picture,
                rating: data?.user?.userInfo?.rattings,
              ), amount: (data?.estimatedFare ?? 0).toString()),
              Gap(8.h),
              locationTime(context,
                  // time: ((order?.duration ?? 0) / 60).toStringAsFixed(1),
                  time: (data?.estimatedTime ?? 0).toStringAsFixed(1),
                distance: (data?.distanceFromDriver ?? 0).toStringAsFixed(1)
              ),
                  // distance: ((order?.distance  ?? 0) / 1000).toStringAsFixed(1)),
              Gap(8.h),
              readAbleLocationView(context, Addresses(
                pickupAddress: data?.pickupLocation?.address,
                dropAddress: data?.dropoffLocation?.address
              )),
              // Gap(8.h),
              // ridePreference(context, preferenceList: order?.ridePreference ?? []),
              Gap(16.h),
              orderRequestButtons(context, orderId: data?.rideRequestId),

            ],
          )

        ),
      ),
    );
}
