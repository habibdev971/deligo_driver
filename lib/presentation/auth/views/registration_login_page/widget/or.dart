import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../generated/l10n.dart';
import 'line.dart';

Widget or(BuildContext context)=> Row(
    children: [
      line(),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.0.w),
        child: Text(AppLocalizations.of(context).or, style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.contentDisable),),
      ),
      line(),
    ],
  );