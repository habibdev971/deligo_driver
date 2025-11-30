import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/presentation/booking/view_model/route_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';

import '../../../core/enums/booking_status.dart';
import '../../../core/utils/localize.dart';
import '../../../gen/assets.gen.dart';
import '../provider/driver_providers.dart';
import '../provider/way_point_list_provider.dart';

Widget headingToDestination(BuildContext context) => Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(
      localize(context).all_set_start_ride,
      style: context.bodyMedium?.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: isDarkMode() ? const Color(0xFF687387) : const Color(0xFF24262D),
      ),
    ),
    Text(
      localize(context).follow_directions_comfortable,
      textAlign: TextAlign.center,
      style: context.bodyMedium?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF687387),
      ),
    ),
    Gap(8.h),
    estimatedTimeWidget(context),

    Assets.images.carAnimation.image(
      height: 200.h,
      width: 358.w,
      fit: BoxFit.fill,
    ),

    Consumer(builder: (context, ref, _){
      final onTripStatusNotifier = ref.read(onTripStatusProvider.notifier);
      return AppPrimaryButton(onPressed: (){
        onTripStatusNotifier.updateOnTripStatus(status: BookingStatus.reachedDestination, );
      }, child: Text('Complete', style: context.bodyMedium?.copyWith(color: Colors.white),));
    })
  ],
);

Widget estimatedTimeWidget(BuildContext context) => Consumer(
  builder: (context, ref, _) {
    final state = ref.watch(routeNotifierProvider);

    final progress = ref.watch(routeProgressProvider);
    // Default value
    String timeText = '0 min';
    String distanceText = '0 km';

    // Update timeText based on state
    state.when(
      initial: () {
        timeText = '0 min';
        distanceText = '0 km';
      },
      loading: () {
        timeText = '0 min';
        distanceText = '0 km';
      },
      success: (data) {
        timeText = formatDuration(data.durationInSeconds);
        distanceText = data.distanceText;
      },
      error: (e) {
        timeText = '0 min';
        distanceText = '0 km';
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time + Distance Info
        Row(
          children: [
            CircleAvatar(
              radius: 15.r,
              backgroundColor: const Color(0xFFF1F7FE),
              child: Icon(
                Icons.access_time,
                color: ColorPalette.primary50,
                size: 20.r,
              ),
            ),
            Gap(5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localize(context).estimated_time,
                    style: context.bodyMedium?.copyWith(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF687387),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: timeText,
                      style: context.bodyMedium?.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: isDarkMode() ? const Color(0xFF687387) : const Color(0xFF24262D),
                      ),
                      children: [
                        TextSpan(
                          text: ' $distanceText',
                          style: context.bodyMedium?.copyWith(
                            fontSize: 10.sp,
                            color: ColorPalette.primary50,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Progress Bar with Car
        SizedBox(
          height: 50.h,
          child: Stack(
            children: [
              // Light background bar
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: isDarkMode() ? Colors.grey.shade500 : const Color(0xFFF1F7FE),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),

              // Blue progress bar
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 10.h,
                  width: MediaQuery.of(context).size.width * 0.8 * progress,
                  margin: EdgeInsets.only(top: 1.h), // Optional fine-tune
                  decoration: BoxDecoration(
                    color: ColorPalette.primary50,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),

              // Car image
              Positioned(
                left:
                    (progress * MediaQuery.of(context).size.width * 0.8 -
                            27.5.w)
                        .clamp(
                          0.0,
                          MediaQuery.of(context).size.width * 0.8 - 55.w,
                        ),
                top: 3.h, // optional: center vertically
                child: Assets.images.carToViewLeftToRight.image(
                  height: 43.h,
                  width: 55.w,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  },
);
