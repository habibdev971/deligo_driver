import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/color_palette.dart';
import '../../../data/services/firebase_auth_service.dart';
import '../../../generated/l10n.dart';

Widget resendOtp(BuildContext context, {required String phoneNumber}){
  TextStyle? textStyle([bool primary = false]) => context.bodyMedium?.copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: primary ? ColorPalette.primary50 : const Color(0xFFB8B8B8),
    );
  return Semantics(
    label: AppLocalizations.of(context).otp_resend_button,
    child: Text.rich(
        TextSpan(
          text: AppLocalizations.of(context).didnt_receive_code,
          style: textStyle(),
      children: [
        TextSpan(
          text: ' ${AppLocalizations.of(context).resend_again}',
          style: textStyle(true),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
            FirebaseAuthService().resendOTP(phoneNumber, onLoadingChange: (val) => debugPrint(val.toString()));

            },
        )
      ]
    )),
  );
}