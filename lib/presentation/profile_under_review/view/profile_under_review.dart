import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/gen/assets.gen.dart';
import 'package:deligo_driver/presentation/auth/widgets/auth_app_bar.dart';

class ProfileUnderReview extends StatelessWidget {
  const ProfileUnderReview({super.key});

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      backgroundColor: isDarkMode() ? context.surface : Colors.white,
      body: AuthAppBar(
        hideTop: true,
        child: Column(
          children: [
            getImage().image(
              height: 322.h,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Gap(24.h),
            Text(
              localize(context).registration_done,
              style: context.bodyMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: ColorPalette.primary50,
              ),
            ),
            Gap(4.h),
            Text(
              localize(context).profile_under_review,
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: isDarkMode() ? const Color(0xFF687387) : const Color(0xFF24262D),
              ),
            ),
            Gap(4.h),
            Text(
              localize(context).profile_submitted_reviewed,
              textAlign: TextAlign.center,
              style: context.bodyMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF687387),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  AssetGenImage getImage()=> isDarkMode() ? Assets.images.profileReviewDark : Assets.images.profileReview;
}
