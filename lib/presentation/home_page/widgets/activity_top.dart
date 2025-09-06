import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/localize.dart';

Widget activityTop(BuildContext context) => Row(
  children: [
    Expanded(
      child: Text(
        localize(context).todays_activity,
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.bodyMedium?.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: isDarkMode() ? Colors.white : const Color(0xFF24262D),
        ),
      ),
    ),
    InkWell(
      onTap: () {},
      child: Text(
        localize(context).view_all,
        style: context.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF8154DA),
        ),
      ),
    ),
  ],
);
