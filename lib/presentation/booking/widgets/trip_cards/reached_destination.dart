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

import '../../../../core/utils/localize.dart';
import '../../provider/ride_providers.dart';

Widget reachedDestination(BuildContext context,  Order? order)=> Consumer(
      builder: (context, ref, _) {
        final rideOrderNotifier = ref.read(rideOrderNotifierProvider.notifier);
        final rideOrderState = ref.read(rideOrderNotifierProvider);
        final onTripNotifier = ref.read(ontripStatusNotifier.notifier);

        return actionSheet(context,
            title: localize(context).reached_passenger_destination,
            description: localize(context).trip_ended_passenger_destination,
            image: Assets.images.reachedDestination.image(height: 130.h, width: 194.w, fit: BoxFit.fill),
            actions: [
              Expanded(
                child: AppPrimaryButton(
                    isLoading: rideOrderState.whenOrNull(loading: ()=> true) ?? false,
                    onPressed: (){
                      rideOrderNotifier.saveOrderStatus(status: 'dropped_off', onSuccess: (v){
                        WidgetsBinding.instance.addPostFrameCallback((_){
                          onTripNotifier.updateOnTripStatus(status: BookingStatus.payment,);
                        });

                      });

                }, child: Text(localize(context).reached_destination, style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white),)),
              )
            ]
        );
      }
  );