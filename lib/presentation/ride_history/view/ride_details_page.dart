
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/widgets/app_bar/app_bar.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';
import 'package:deligo_driver/presentation/booking/provider/pusher_provider.dart';
import 'package:deligo_driver/presentation/booking/provider/ride_providers.dart';
import 'package:deligo_driver/presentation/dashboard/view_model/currency_notifier.dart';
import 'package:deligo_driver/presentation/ride_history/widgets/schedule_info.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../../data/models/order_response/order_model/address/address.dart';
import '../../../data/models/order_response/order_model/points/points.dart';
import '../../../data/models/ride_details_model/RideDetailsModel.dart';
import '../../../data/services/navigation_service.dart';
import '../../account_page/provider/theme_provider.dart';
import '../../booking/provider/way_point_list_provider.dart';
import '../../booking/widgets/icon_destination.dart';
import '../../home_page/provider/home_notifier_provider.dart';


class RideDetailsPage extends ConsumerStatefulWidget {
  const RideDetailsPage({super.key, required this.order});
  final RideRequest order;

  @override
  ConsumerState<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends ConsumerState<RideDetailsPage> {

  late bool isDark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDark = ref.read(themeModeProvider.notifier).isDarkMode();
  }

  // @override
  // void dispose() {
  //   setStatusBar(isDark: isDark);
  //   super.dispose();
  // }
  // void _copyText(BuildContext context, String text) {
  //   Clipboard.setData(ClipboardData(text: text));
  //   showNotification(message: AppLocalizations.of(context).textCopied, isSuccess: true);
  // }

  @override
  Widget build(BuildContext context, ) {
    // final bool isComplete = widget.order.status != null &&
    //     widget.order.status!.toLowerCase().contains('completed');
    final bool hideMapButton = widget.order.status != null && (widget.order.status!.contains('COMPLETED') || widget.order.status!.contains('CANCELLED') );
    final rideDetailState = ref.watch(rideDetailsProvider);
    final isDetailLoading = rideDetailState.whenOrNull(loading: ()=> true) ?? false;
    final bool isDark = isDarkMode();
    return Scaffold(
      appBar: mainAppBar(context, ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 8.r),
                  padding: EdgeInsets.all(16.r),
                  color: isDarkMode() ? Colors.black12 : Colors.white,
                  child: Column(
                    children: [
                      // rideActivityCard(context, order: widget.order, showCancelItem: !isComplete, isDark: isDark),
                      // Gap(8.h),
                      readAbleLocationView(context, widget.order.addresses,
                          backGroundColor: isDark ? Colors.black12 : Colors.white, isDark: isDark),
                      // Gap(isComplete ? 16.h : 0),
                      // !isComplete
                      //     ? Padding(
                      //         padding:
                      //             const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                      //         child: rowTextDetail(context,
                      //             title: 'Status',
                      //             value: Expanded(
                      //               child: Text(
                      //                 widget.order.status?.capitalize() ?? 'N/A',
                      //                 maxLines: 1,
                      //                 overflow: TextOverflow.ellipsis,
                      //                 textAlign: TextAlign.end,
                      //                 style: context.bodyMedium?.copyWith(
                      //                     fontSize: 12.sp,
                      //                     fontWeight: FontWeight.w600,
                      //                     color: isComplete
                      //                         ? const Color(0xFF36B37E)
                      //                         : const Color(0xFFFF5630)),
                      //               ),
                      //             ), isDark: isDark),
                      //       )
                      //     :
                      Gap(16.h),
                      scheduleInfo(context, order: widget.order),
                      Gap(16.h),
                    serviceOverView(context, widget.order, widgets: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                                child: rowTextDetail(context,
                                    title: 'Status',
                                    value: Expanded(
                                      child: Text(
                                        widget.order.status?.capitalize() ?? 'N/A',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                        style: context.bodyMedium?.copyWith(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: widget.order.status != null && widget.order.status!.contains('COMPLETED')
                                                ? const Color(0xFF36B37E)
                                                : const Color(0xFFFF5630)),
                                      ),
                                    ), isDark: isDark),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                                child: rowTextDetail(context,
                                    title: 'Payment Method',
                                    value: Expanded(
                                      child: Text(
                                        widget.order.payMethod ?? 'N/A',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                        style: context.bodyMedium?.copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E)),
                                      ),
                                    ), isDark: isDark),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: const Divider(),
                              ),
                        // rowText(context, title: "Ride Type", isDark: isDark, value: widget.order?.ty)
                            ], isDark: isDark),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h).copyWith(bottom: MediaQuery.of(context).viewPadding.bottom),
              decoration:  BoxDecoration(
                color: isDarkMode() ? Colors.black12 : Colors.white,
              ),
              child: Row(
                children: [
                  // Expanded(
                  //     child: issueButton(
                  //         context,
                  //         isLoading: isDetailLoading,
                  //         onTap: (){
                  //
                  //         },
                  //         title: "Report Issue",
                  //         icon: Ionicons.book_outline,
                  //         backgroundColor: const Color(0xFFFFF1EE),
                  //         textColor: const Color(0xFFFF5630))),
                  Expanded(child: AppPrimaryButton(
                      isDisabled: isDetailLoading,
                      onPressed: (){
                    NavigationService.pushNamed(AppRoutes.complaintPage, arguments: widget.order.id);
                  }, title: 'Report Issue',
                  backgroundColor: Colors.red,
                  )),
                  Gap( hideMapButton ? 0 : 16.w),
                  Visibility(
                    visible: !hideMapButton,
                    child: Expanded(child: AppPrimaryButton(
                      isLoading: isDetailLoading,
                        backgroundColor: Colors.green,
                        showBorder: false,
                        onPressed: ()async{
                        final Points? points = widget.order.points;
                        await LocalStorageService().saveRideId(widget.order.id);
                        await ref.read(rideDetailsProvider.notifier).getRideDetails(widget.order.id);
                        // ref.read(wayPointListNotifierProvider.notifier).setWayPointList([
                        //   Waypoint(name: 'Pick-up point', address: address?.pickupAddress ?? '', location: LatLng(points?.pickupLocation?.first.toDouble() ?? 0, points?.pickupLocation?.last.toDouble() ?? 0)),
                        //   Waypoint(name: 'Drop-off point', address: address?.dropAddress ?? '', location: LatLng(points?.dropLocation?.first.toDouble() ?? 0, points?.dropLocation?.last.toDouble() ?? 0)),
                        // ]);
                        // ref.read(tripProvider.notifier).goForOrderAccept();
                        ref.read(pusherNotifierProvider.notifier).setupPusherListeners();
                        ref.read(routeNotifierProvider.notifier).fetchRoutesDetail(points, orderId: widget.order.id);
                        // ref.read(homeProvider.notifier).updateForAccepted();

                        // NavigationService.pushNamedAndRemoveUntil(AppRoutes.tripPage);
                        }, title: 'Go to Map')),
                  )
                ],
              ),
            ),
            Gap(16.h)
            // Gap(isIos() ? 0 : 16.h)
          ],
        ),
      ),
    );
  }
}

Widget rowTextDetail(BuildContext context,
    {required String title, Widget? value, required bool isDark}) => Row(
    children: [
      Expanded(
          child: Text(
        title,
            // textAlign: isArabic() ? TextAlign.right : TextAlign.left,
        style: context.bodyMedium?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E)),
      )),
      if (value != null) value,
      ],
  );

Widget issueButton(BuildContext context,
    {String title = '',
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    Function()? onTap,
      bool isLoading = false,
    }) => InkWell(
    onTap: isLoading ? null : onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 8.w),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(4.r)),
      child: isLoading ? SizedBox(
          height: 25.h,
          width: 25.w,
          child: const Center(child: CircularProgressIndicator(),)) : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: textColor,
            size: 18.h,
          ),
          Gap(6.w),
          Flexible(
              child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: context.bodyMedium?.copyWith(
                fontSize: 14.sp, fontWeight: FontWeight.w400, color: textColor),
          )),
        ],
      ),
    ),
      );

Widget readAbleLocationView(
    BuildContext context,
    Addresses? address, {
      Color? backGroundColor,
      required bool isDark,
    }) => Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Column(
      children: [
        getCircleBackground(
          const IconDestination(isPickupPoint: true, color: ColorPalette.primary50),
          backgroundColor: isDark ? const Color(0xFF687387) : null,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: DottedLine(
            direction: Axis.vertical,
            dashColor: ColorPalette.neutral90,
            // lineThickness: 1,
            lineLength: 50,
          ),
        ),

        getCircleBackground(
          const IconDestination(color: ColorPalette.primary50),
          backgroundColor: isDark ? const Color(0xFF687387) : null,
        ),
      ],
    ),
    Gap(8.w),
    Expanded(
      child: Column(
        children: [
          locationBackground(
            context,
            title: 'Pick-up',
            subTitle: address?.pickupAddress,
            backGroundColor: backGroundColor, isDark: isDark,
          ),
          Gap(8.h),
          locationBackground(
            context,
            title: 'Destination',
            subTitle: address?.dropAddress,
            backGroundColor: backGroundColor, isDark: isDark,
          ),
        ],
      ),
    ),
  ],
);

Widget getCircleBackground(Widget child, {Color? backgroundColor}) =>
    CircleAvatar(
      radius: 14.r,
      backgroundColor: backgroundColor ?? const Color(0xFFF1F7FE),
      child: child,
    );

Widget locationBackground(
    BuildContext context, {
      required String title,
      String? subTitle,
      Color? backGroundColor,
      required bool isDark,
    }) => Container(
  width: double.infinity,
  padding: EdgeInsets.all(12.r),
  decoration: BoxDecoration(
    color: backGroundColor ?? const Color(0xFFF1F7FE),
    borderRadius: BorderRadius.circular(8.r),
    border: Border.all(color: const Color(0xFFE3EEFB), width: 1.w),
  ),

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: context.bodyMedium?.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: ColorPalette.primary50,
        ),
      ),
      Gap(8.h),
      Text(
        subTitle ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: isDark ? const Color(0xFF687387) : const Color(0xFF24262D),
        ),
      ),
    ],
  ),
);


Widget serviceOverView(
    BuildContext context,
    RideRequest order, {
      List<Widget>? widgets,
      required bool isDark
    }) => Consumer(
      builder: (context, ref, _) {
        final currency = ref.watch(currencyProvider);
        return Container(
          decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFF1F7FE)),
          ),
          child: Column(
        children: [
          if (widgets != null) ...widgets,
          Padding(
            padding:
            EdgeInsets.only(left: 8.0.w, right: 8.w, top: 8.h, bottom: 8.h),
            child: rowText(context,
                title: 'Ride Charge',
                value: '$currency${order.estimatedFare?.toString() ?? 0.0}', isDark: isDark),
          ),
          // Padding(
          //   padding: EdgeInsets.all(8.0.r),
          //   child: rowText(
          //     context,
          //     title: AppLocalizations.of(context).service_charge,
          //     value:
          //         r'$'
          //         '${order.service?.baseFare ?? 0.00}', isDark: isDark,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 8.w, bottom: 8.h),
            child: rowText(
              context,
              title: 'Discount',
              value: currency + (order.discount ?? 0).toString(), isDark: isDark,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r),
              ),
              color: isDark ? Colors.grey.shade900 : ColorPalette.neutralF6,
            ),
            child: rowText(
              context,
              title: 'Total Amount',
              value:

              '$currency${order.estimatedFare ?? 0.00}',
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1469B5), isDark: isDark,
            ),
          ),
        ],
          ),
        );
      }
    );

Widget rowText(
    BuildContext context, {
      required String title,
      value,
      double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      bool showBackground = false,
      Color? backgroundColor,
      Color? rVColor,
      required bool isDark
    }) => Row(
  children: [
    Expanded(
      child: Text(
        title,
        // textAlign: isArabic() ? TextAlign.right : TextAlign.left,
        textAlign: TextAlign.left,
        style: context.bodyMedium?.copyWith(
          fontSize: (fontSize ?? 14).sp,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? (isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E)),
        ),
      ),
    ),
    Expanded(
      child: Container(
        decoration: showBackground
            ? BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: backgroundColor,
        )
            : null,
        child: Text(
          value ??  '',
          textAlign: TextAlign.right,
          style: context.bodyMedium?.copyWith(
            fontSize: (fontSize ?? 14).sp,
            fontWeight: fontWeight ?? FontWeight.w400,
            color: rVColor ?? color ?? (isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E)),
          ),
        ),
      ),
    ),
  ],
);