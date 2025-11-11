import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/iso_date_time_formater.dart';
import 'package:deligo_driver/presentation/ride_history/view/ride_details_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../data/models/ride_details_model/RideDetailsModel.dart';

Widget scheduleInfo(BuildContext context, {required RideRequest order}){
  final bool isScheduleRide = order.serviceTypeId == 2;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: const Color(0xFFF1F7FE)),
    ),
    padding: EdgeInsets.all(8.r),
    child: Column(
      children: [
        rowText(context, title: 'Ride Type', isDark: isDarkMode(), value: isScheduleRide ? 'Scheduled' : 'Book Now'),
        Gap(4.h),
        //isScheduleRide ? "Scheduled Date & Time" :
        rowText(context, title: 'Ride Time', isDark: isDarkMode(), value: isScheduleRide ? isoDateFormater(isoDateTime: order.scheduledAt) : isoDateFormater(isoDateTime: order.orderTime)),
        Gap(4.h),
        rowText(context, title: 'Distance', isDark: isDarkMode(), value: '${order.distance ?? 0} km'),
        Gap(4.h),
        rowText(context, title: 'Duration', isDark: isDarkMode(), value: '${order.estimatedTime ?? 0} min'),
      ],
    ),
  );
}