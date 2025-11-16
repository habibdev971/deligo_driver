import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/generated/l10n.dart';
import 'package:gap/gap.dart';

import '../../../../../data/services/url_launch_services.dart';

Widget termsAndCondition(
  BuildContext context, {
  bool loginPage = false,
  bool isSelected = true,
  required void Function() onTap,
}) {
  TextStyle? textStyle([bool primary = false]) {
    return context.bodyMedium?.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: primary ? ColorPalette.primary50 : const Color(0xFFB8B8B8),
    );
  }

  return loginPage
      ? Gap(20.h)
      : Semantics(
          label: AppLocalizations.of(context).terms_conditions_checkbox,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  // Icon(Icons.)
                  IconButton(
                    onPressed: onTap,
                    icon: isSelected
                        ? const Icon(Icons.check_box_rounded, color: ColorPalette.primary50,)
                        : const Icon(
                            Icons.check_box_outline_blank_rounded,
                            color: Colors.red,
                          ),
                  ),
                  Gap(4.w),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: AppLocalizations.of(context).terms_agreement,
                        style: textStyle(),
                        children: [
                          TextSpan(
                            text:
                                ' ${AppLocalizations.of(context).terms_of_service}',
                            style: textStyle(true),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                UrlLaunchServices.launchUrls('https://deligoeu.com/term.html');
                                // Handle Terms of Service tap
                                // debugPrint("Terms of Service tapped");
                                // Navigator.push(...) or launch URL
                              },
                          ),
                          TextSpan(
                            text: ' ${AppLocalizations.of(context).and}',
                            style: textStyle(),
                          ),
                          TextSpan(
                            text:
                                ' ${AppLocalizations.of(context).privacy_policy}',
                            style: textStyle(true),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle Privacy Policy tap
                                UrlLaunchServices.launchUrls('https://deligoeu.com/term.html');
                                // debugPrint("Privacy Policy tapped");
                                // Navigator.push(...) or launch URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(40.h),
            ],
          ),
        );
}
