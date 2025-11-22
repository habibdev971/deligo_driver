import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/generated/l10n.dart';
import 'package:deligo_driver/presentation/auth/views/registration_login_page/widget/text_field_only.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textField(
  BuildContext context,
  TextEditingController controller, {
  String? hint,
  Widget? suffix,
  Widget? prefix,
  String? Function(String?)? validator,
      void Function(String? v)? onChange,
  TextInputType? keyboardType,
  bool emailOrPhoneEnable = false,
      bool obscureText = false,
      bool readOnly = false,
      bool hideValidator = false
}) {
  String? Function(String?)? dynamicValidator = validator;

  if (validator == null && keyboardType != null) {
    if (keyboardType == TextInputType.emailAddress) {
      dynamicValidator = (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context).validator_email_required;
        } else if (keyboardType == TextInputType.phone) {
      dynamicValidator = (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context).validator_phone_required;
        }
        if (value.length < 7) {
          return AppLocalizations.of(context).validator_phone_invalid;
        }
        return null;
      };
    } else if (keyboardType == TextInputType.number) {
      dynamicValidator = (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context).validator_number_required;
        }
        if (double.tryParse(value) == null) {
          return AppLocalizations.of(context).validator_number_invalid;
        }
        return null;
      };
    } else if (keyboardType == TextInputType.visiblePassword) {
      dynamicValidator = (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context).validator_password_required;
        }
        if (value.length < 6) {
          return AppLocalizations.of(context).validator_password_too_short;
        }
        return null;
      };
    } else if (keyboardType == TextInputType.name) {
      dynamicValidator = (value) {
        if (value == null || value.trim().isEmpty) {
          return AppLocalizations.of(context).validator_name_required;
        }
        if (value.trim().length < 2) {
          return AppLocalizations.of(context).validator_name_invalid;
        }
        return null;
      };
    }else{
      return null;
        }};
  }}

  return FormField<String>(
    validator: readOnly || hideValidator ? null : dynamicValidator,
    autovalidateMode: readOnly || hideValidator ? null : dynamicValidator == null
        ? null
        : AutovalidateMode.onUserInteraction,
    builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textFieldOnly(
            hint: hint,
            obscureText: obscureText,
            suffix: suffix,
            prefix: prefix,
            controller: controller,
            state: state,
            keyboardType: keyboardType,
            validator: readOnly || hideValidator ? null : validator,
            readOnly: readOnly,
            onChange: onChange
          ),
          SizedBox(height: 4.h),
          if (state.hasError)
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Text(
                state.errorText ?? '',
                style: context.bodyMedium?.copyWith(
                  fontSize: 12.sp,
                  color: Colors.red,
                  height: 1.2,
                ),
              ),
            ),

          SizedBox(height: 16.h), // reserve height
        ],
      ),
  );
}
