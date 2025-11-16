
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/color_palette.dart';
import '../../../../../core/utils/is_dark_mode.dart';
import '../../../../../core/widgets/custom_dropdown.dart';
import '../../../../../generated/l10n.dart';

Widget genderDropdown(
    BuildContext context,
    TextEditingController selectedGender, {
      String? Function(String?)? validator,
      bool readOnly = false,
    }) {
  TextStyle? textStyle([bool isSelected = false]) => context.bodyMedium?.copyWith(
      fontSize: 16.sp,
      color: isSelected
          ? ColorPalette.primary50
          : isDarkMode()
          ? Colors.white
          : Colors.black,
    );

  return StatefulBuilder(
    builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customDropdown<String>(
            context,
            readOnly: readOnly,
            value: selectedGender.text.isEmpty ? null : selectedGender.text,
            hint: AppLocalizations.of(context).gender,
            // যখন overlay খোলে তখন Flutter নিজেই selected item হাইলাইট করে।
            // selectedItemBuilder কেবল dropdown বন্ধ অবস্থায় দেখানোর জন্য।
            selectedItemBuilder: (context) => [
                Text(AppLocalizations.of(context).male,
                    style: textStyle()),
                Text(AppLocalizations.of(context).female,
                    style: textStyle()),
                Text(AppLocalizations.of(context).other,
                    style: textStyle()),
              ],
            items: [
              DropdownMenuItem(
                value: 'male',
                child: Text(AppLocalizations.of(context).male, style: textStyle(selectedGender.text == 'male')),
              ),
              DropdownMenuItem(
                value: 'female',
                child: Text(AppLocalizations.of(context).female, style: textStyle(selectedGender.text == 'female')),
              ),
              DropdownMenuItem(
                value: 'other',
                child: Text(AppLocalizations.of(context).other, style: textStyle(selectedGender.text == 'other')),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedGender.text = value;
                });
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
      ),
  );
}


