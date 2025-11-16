import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../gen/assets.gen.dart';

Widget socialButton(BuildContext context, {required AssetGenImage logo, required String title, void Function()? onTap}){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: const Color(0xFFD0D0D0), width: 1.w)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              logo.image(height: 24.h, width: 24.w),
              Gap(8.w),
              Flexible(child: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFF5A5A5A)),)),
            ],
          ),
        ),
      ),
      Gap(20.h)
    ],
  );
}