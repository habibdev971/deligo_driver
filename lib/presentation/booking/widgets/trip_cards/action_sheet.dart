import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';

Widget actionSheet(BuildContext context, {
  Widget? riderInfo,
  Widget? locationTime,
  String title = '',
  String description = '',
  required Widget image,
  Widget? content,
  List<Widget> actions = const <Widget>[],})=> Column(
    children: [
      riderInfo ?? const SizedBox.shrink(),
      Gap(locationTime != null ? 8.h : 0),
      locationTime ?? const SizedBox.shrink(),
      Gap(8.h),
      Text(
        title,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium?.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: isDarkMode() ? const Color(0xFF687387) : const Color(0xFF24262D),
        ),
      ),
      Gap(4.h),
      Text(
        description,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF687387),
        ),
      ),
      Gap(8.h),
      image,
      Gap(content != null ? 8.h : 0),
      content ?? const SizedBox.shrink(),
      Gap(16.h),
      Row(
      children: actions,
      ),
    ],
  );