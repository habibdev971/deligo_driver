
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/is_dark_mode.dart';

Widget listTile(
    BuildContext context, {
     Widget? leading,
      Widget? trailing,
      String? title,
      String? subtitle,
      Color? subTitleColor,
      double bottomPadding = 12,
      int maxLines = 1,
      double height = 65,
      TextOverflow overflow = TextOverflow.ellipsis,
      Function()? onTap,
    }) => Container(
    margin: EdgeInsets.only(bottom: bottomPadding.h),
    height: height.h,
    alignment: Alignment.center,
    child: ListTile(
      onTap: onTap,
      minVerticalPadding: 0,
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      shape: RoundedRectangleBorder(
        side:  const BorderSide(color: ColorPalette.primary50, width: 1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      leading: leading,
      title: Text(
        title ?? 'N/A',
        maxLines: maxLines,
        overflow: overflow,
        style: context.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isDarkMode() ? Colors.white54 : const Color(0xFF121212),
        ),
      ),
      subtitle: Text(
        subtitle ?? 'N/A',
        maxLines: maxLines,
        overflow: overflow,
        style: context.bodyMedium?.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: subTitleColor ?? AppColors.textTertiary,
        ),
      ),
      trailing: trailing,
    ),
  );
