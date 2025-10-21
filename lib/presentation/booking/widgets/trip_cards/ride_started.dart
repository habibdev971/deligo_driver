import 'package:deligo_driver/presentation/booking/provider/save_order_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deligo_driver/core/enums/booking_status.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/data/models/order_response/order_model/order/order.dart';
import 'package:deligo_driver/gen/assets.gen.dart';
import 'package:deligo_driver/presentation/booking/provider/driver_providers.dart';
import 'package:deligo_driver/presentation/booking/widgets/trip_cards/action_sheet.dart';
import 'package:deligo_driver/presentation/home_page/widgets/rider_details.dart';
import 'package:deligo_driver/presentation/home_page/widgets/location_time_calculated.dart';

import '../../../../core/utils/localize.dart';

Widget rideStarted(BuildContext context,  Order? order)=> Consumer(
      builder: (context, ref, _) {
        final rideOrderNotifier = ref.read(saveOrderStatusProvider.notifier);
        final onTripNotifier = ref.read(ontripStatusNotifier.notifier);
        return actionSheet(context,
            riderInfo: riderDetails(context, order?.rider),
            locationTime: locationTime(context),
            title: localize(context).all_set_start_ride,
            description: localize(context).start_journey_navigation,
            image: Assets.images.startRide.image(height: 130.h, width: 194.w, fit: BoxFit.fill),
            actions: [
              Expanded(
                child: AppPrimaryButton(onPressed: (){
                  rideOrderNotifier.saveOrderStatus(status: 'START', onSuccess: (v){
                    WidgetsBinding.instance.addPostFrameCallback((_){
                      onTripNotifier.updateOnTripStatus(status: BookingStatus.headingToDestination, );
                    });
                  });

                }, child: Text(localize(context).tap_to_start_ride, style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),)),
              )
            ]
        );
      }
  );