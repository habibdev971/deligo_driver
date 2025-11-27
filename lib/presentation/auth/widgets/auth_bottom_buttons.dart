import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../../core/widgets/buttons/app_primary_button.dart';


class AuthBottomButtons extends StatelessWidget {
  const AuthBottomButtons(
      {super.key, this.showBothButtons = false, this.onSkip, required this.title, required this.onTap, this.isLoading = false, });
  final bool showBothButtons;
  final Function()? onSkip;
  final Function() onTap;
  final String title;
  final bool isLoading;


  @override
  Widget build(BuildContext context) => SafeArea(
    child: Container(
        height: 96.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: isDarkMode() ? context.surface : Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: AppPrimaryButton(
                isDisabled: isLoading,
                onPressed: onTap,
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.neutral100),
                ),
              ),
            ),
          ],
        ),
      ),
  );
}
