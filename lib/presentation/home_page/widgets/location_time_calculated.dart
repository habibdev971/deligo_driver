import 'package:deligo_driver/presentation/booking/view_model/route_notifier.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../../gen/assets.gen.dart';
import '../../booking/provider/way_point_list_provider.dart';

Widget locationTime(BuildContext context, {String? time, String? distance, bool showHourMin = false}) =>
    Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(routeNotifierProvider);
        final bool showOnlyRouteTimes = time == null || distance == null;

        // Default value
        String timeText = '';
        String distanceText = '';

        // Update timeText based on state
        state.whenOrNull(
          // initial: () {
          //   // timeText = '0 min';
          //   // distanceText = '0 km';
          // },
          // loading: () {
          //   timeText = '0 min';
          //   distanceText = '0 km';
          // },
          success: (data) {
            timeText = showHourMin ? formatDurationSeconds(data.durationInSeconds) : data.durationText;
            distanceText = data.distanceText;
          },
          // error: (e) {
          //   timeText = '0 min';
          //   distanceText = '0 km';
          // },
        );
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: isDarkMode() ? Colors.black : const Color(0xFFF6F4FE),
          ),
          child: Row(
            children: [
              infoCard(context, title: showOnlyRouteTimes ? distanceText : ('${distance}km') ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: DottedLine(
                  dashColor: ColorPalette.neutral90,
                  lineThickness: 3,
                  lineLength: 80,
                ),
              ),
              infoCard(context, showImage: false, title: showOnlyRouteTimes ? timeText : ('${time}min')),
            ],
          ),
        );
      },
    );

Widget infoCard(BuildContext context, {bool showImage = true, String? title}) =>
    Expanded(
      child: Container(
        height: 40.h,
        width: double.infinity,
        padding: EdgeInsets.all(8.r),
        child: Row(
          children: [
            showImage
                ? Assets.images.route.image(
                    height: 24.h,
                    width: 24.w,
                    fit: BoxFit.fill,
                  )
                : Icon(
                    Ionicons.time_outline,
                    color: ColorPalette.primary50,
                    size: 24.r,
                  ),
            Gap(8.w),
            Expanded(
              child: Text(
                title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode() ? Colors.white : const Color(0xFF24262D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
