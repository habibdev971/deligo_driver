import 'package:deligo_driver/data/models/ride_details_model/RideDetailsModel.dart';
import 'package:deligo_driver/presentation/booking/provider/ride_providers.dart';
import 'package:deligo_driver/presentation/booking/provider/save_order_status_provider.dart';
import 'package:deligo_driver/presentation/dashboard/view_model/currency_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deligo_driver/core/enums/booking_status.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/routes/app_routes.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/utils/is_arabic.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/gen/assets.gen.dart';
import 'package:deligo_driver/presentation/booking/provider/driver_providers.dart';
import 'package:deligo_driver/presentation/booking/provider/home_providers.dart';
import 'package:deligo_driver/presentation/booking/provider/pusher_provider.dart';
import 'package:deligo_driver/presentation/booking/widgets/trip_cards/action_sheet.dart';
import '../../../../core/utils/is_dark_mode.dart';

Widget paymentReceived(BuildContext context, RideRequest? order) => Consumer(builder: (context, ref, _) {
    final rideOrderNotifier = ref.read(saveOrderStatusProvider.notifier);
    final rideOrderState = ref.watch(saveOrderStatusProvider);
    final tripStateNotifier = ref.read(onTripStatusProvider.notifier);
    final bookingNotifier = ref.read(bookingNotifierProvider.notifier);
    final pusherNotifier = ref.read(pusherNotifierProvider.notifier);
    return actionSheet(context,
        title: localize(context).ride_complete,
        description:
        localize(context).trip_ended_wait_payment,
        image: Assets.images.paymentReceived
            .image(height: 125.h, width: 201.w, fit: BoxFit.fill),
        content: serviceOverView(context, order, widgets: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: rowText(context,
                title: localize(context).payout_method, value: order?.payMethod?.capitalize()),
          ),
        ]),
        actions: [
          Expanded(
            child: AppPrimaryButton(
                isLoading:
                rideOrderState.whenOrNull(loading: () => true) ?? false,
                onPressed: () {
                  rideOrderNotifier.saveOrderStatus(
                      status: 'END',
                      onSuccess: (v) {
                        WidgetsBinding.instance.addPostFrameCallback((_) async{

                          tripStateNotifier.updateOnTripStatus(
                                  status: BookingStatus.goForPickup,
                                  );

                          pusherNotifier.disconnect();
                          bookingNotifier.resetToInitial();
                          await LocalStorageService().clearOrderId();
                          pusherNotifier.setupPusherListeners();
                          ref.read(rideDetailsProvider.notifier).reset();
                          NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
                        });
                      });
                },
                child: Text(
                  localize(context).payment_received,
                  style: context.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
          )
        ]);
  });

Widget serviceOverView(BuildContext context, RideRequest? order,
    {List<Widget>? widgets}) => Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFF1F7FE))),
    child: Consumer(
      builder: (context, ref, _) {
        final currency = ref.watch(currencyProvider);
        return Column(
          children: [
            if (widgets != null) ...widgets,
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: rowText(context,
                  title: localize(context).rideCharge,
                  value:  '${order?.estimatedFare ?? 0.00}$currency'),
            ),

            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: rowText(context,
                  title: localize(context).discount,
                  value:  '${order?.discount ?? 0.00}$currency'),
            ),
            // Padding(
            //   padding: EdgeInsets.all(8.0.r),
            //   child: rowText(context,
            //       title: localize(context).service_charge,
            //       value: '${order?.service?.baseFare ?? 0.00}$currency'),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 8.0.w, right: 8.w, bottom: 8.h),
            //   child: rowText(context, title: localize(context).discount, value: (order?.discount ?? 0).toString() + currency),
            // ),
            Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8.r),
                        bottomLeft: Radius.circular(8.r)),
                    color: isDarkMode() ? Colors.grey.shade900 : const Color(0xFFF6F4FE)),
                child: rowText(context,
                    title: localize(context).total_amount,
                    value: '${order?.estimatedFare ?? 0.00}$currency',
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.primary50)),
          ],
        );
      }
    ),
  );

Widget rowText(BuildContext context,
    {required String title,
    value,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    bool showBackground = false,
    Color? backgroundColor,
    Color? rVColor}) => Row(
    children: [
      Expanded(
          child: Text(
        title,
        textAlign: isArabic() ? TextAlign.right : TextAlign.left,
        style: context.bodyMedium?.copyWith(
            fontSize: (fontSize ?? 14).sp,
            fontWeight: fontWeight ?? FontWeight.w400,
            color: isDarkMode() ? Colors.grey.shade500 : color ?? const Color(0xFF2E2E2E)),
      )),
      Expanded(
          child: Container(
              decoration: showBackground
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: backgroundColor)
                  : null,
              child: Text(
                value ?? '',
                textAlign: isArabic() ? TextAlign.left : TextAlign.right,
                style: context.bodyMedium?.copyWith(
                    fontSize: (fontSize ?? 14).sp,
                    fontWeight: fontWeight ?? FontWeight.w400,
                    color: isDarkMode() ? Colors.grey.shade500 : rVColor ?? color ?? const Color(0xFF2E2E2E)),
              ))),
    ],
  );
