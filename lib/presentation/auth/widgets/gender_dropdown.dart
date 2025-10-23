import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/is_dark_mode.dart';
import '../../../generated/l10n.dart';

Widget genderDropdown(
    BuildContext context,
    TextEditingController selectedGender,
    {
      // void Function(String?)? onChanged,
      String? Function(String?)? validator,
    }) {

  TextStyle? textStyle(){
    return context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFFD0D0D0));
  }
  return FormField<String>(
    validator: validator ??
            (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context).gender_required;
          }
          return null;
        },
    autovalidateMode: AutovalidateMode.onUserInteraction,
    builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: state.hasError ? Colors.red : const Color(0xFFD7DAE0),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedGender.text.isEmpty ? null : selectedGender.text,
                hint: Text(AppLocalizations.of(context).gender, style: textStyle()),
                items: [
                  DropdownMenuItem(
                    value: 'male',
                    child: Text(AppLocalizations.of(context).male, style: textStyle()),
                  ),
                  DropdownMenuItem(
                    value: 'female',
                    child: Text(AppLocalizations.of(context).female, style: textStyle(),),
                  ),
                  DropdownMenuItem(
                    value: 'other',
                    child: Text(AppLocalizations.of(context).other, style: textStyle(),),
                  ),
                ],
                onChanged: (value) {
                  if(value != null){
                    selectedGender.text = value;
                    // onChanged(value);
                    state.didChange(value);
                  }

                },
                dropdownColor: isDarkMode() ? Colors.black : Colors.white,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          if (state.hasError)
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Text(
                state.errorText ?? '',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.red,
                  height: 1.2,
                ),
              ),
            ),
          SizedBox(height: 16.h),
        ],
      ),
  );
}
