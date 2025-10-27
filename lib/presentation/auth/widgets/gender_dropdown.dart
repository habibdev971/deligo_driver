import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/is_dark_mode.dart';
import '../../../core/widgets/custom_dropdown.dart';
import '../../../generated/l10n.dart';

Widget genderDropdown(
    BuildContext context,
    TextEditingController selectedGender, {
      String? Function(String?)? validator,
      bool readOnly = false
    }) {
  TextStyle? textStyle() => context.bodyMedium?.copyWith(
      fontSize: 16.sp,
      // fontWeight: FontWeight.w500,
      color: isDarkMode() ? Colors.white : Colors.black,
    );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customDropdown<String>(
        context,
        readOnly: readOnly,
        value: selectedGender.text.isEmpty ? null : selectedGender.text,
        hint: AppLocalizations.of(context).gender,
        items: [
          DropdownMenuItem(
            value: 'male',
            child: Text(AppLocalizations.of(context).male, style: textStyle()),
          ),
          DropdownMenuItem(
            value: 'female',
            child: Text(AppLocalizations.of(context).female, style: textStyle()),
          ),
          DropdownMenuItem(
            value: 'other',
            child: Text(AppLocalizations.of(context).other, style: textStyle()),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            selectedGender.text = value;
          }
        },
        validator: validator ??
                (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context).gender_required;
              }
              return null;
            },
        autoValidateMode: AutovalidateMode.onUserInteraction,
        menuPadding: EdgeInsets.only(left: 16.w),
      ),
      SizedBox(height: 16.h),
    ],
  );
}
