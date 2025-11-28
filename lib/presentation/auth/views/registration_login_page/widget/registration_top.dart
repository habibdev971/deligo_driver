import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';


Widget registrationTop(BuildContext context, {bool loginPage = false}) => Padding(
    padding: EdgeInsets.only(right: 41.w, bottom: 30.h),
    child: Semantics(
      label: loginPage
          ? AppLocalizations.of(context).sign_up_sign_in
      // AppLocalizations.of(context).sign_in_heading
          : AppLocalizations.of(context).registration_heading,
      header: true,
      child: Text(
        loginPage
            ? AppLocalizations.of(context).sign_up_sign_in
            : AppLocalizations.of(context).sign_up_with_email_or_phone,
        textAlign: TextAlign.center,
        style: context.bodyMedium?.copyWith(
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          color: isDarkMode() ? Colors.white : AppColors.textSecondary,
        ),
      ),
    ),
  );
