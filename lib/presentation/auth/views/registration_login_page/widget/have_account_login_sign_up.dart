import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/routes/app_routes.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/generated/l10n.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/color_palette.dart';

Widget alreadyHaveAccountLoginSignUp(BuildContext context, {bool loginPage = false}){

  TextStyle? textStyle([bool primary = false]) => context.bodyMedium?.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: primary ? ColorPalette.primary50 : const Color(0xFFB8B8B8),
    );

  return Semantics(
    label: '${AppLocalizations.of(context).already_have_account} ${loginPage ? AppLocalizations.of(context).sign_up : AppLocalizations.of(context).sign_in}',
    child: Text.rich(TextSpan(
      text: loginPage ? "Don't have account? " : AppLocalizations.of(context).already_have_account,
      children: [
        TextSpan(
          text: ' ${loginPage ? AppLocalizations.of(context).sign_up : AppLocalizations.of(context).sign_in}',
          style: textStyle(true),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
            NavigationService.pushNamed(AppRoutes.loginSignUp, arguments: {'isLoginPage': !loginPage});

            },
        ),
      ]
    )),
  );
}