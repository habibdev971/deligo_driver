import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/services/navigation_service.dart';
import '../../../generated/l10n.dart';
import '../../utils/app_colors.dart';
import '../../utils/is_dark_mode.dart';

Widget backButton(BuildContext context, {Function()? onPressed})=> IconButton(
    onPressed: onPressed ?? () => NavigationService.pop(),
    icon: Row(
      children: [
        Icon(
          Icons.arrow_back_ios_new,
          size: 24.h,
          color: isDarkMode() ? Colors.white : AppColors.textSecondary,
        ),
        Expanded(child: Text(
          AppLocalizations.of(context).back,
          style: context.bodyMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: isDarkMode() ? Colors.white : AppColors.textSecondary,
          ),
        ),)

      ],
    ),
  );