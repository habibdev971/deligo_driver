import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/is_dark_mode.dart';

Widget textFieldOnly({
  String? hint,
  Widget? suffix,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
  TextEditingController? controller,
  FormFieldState<String>? state,
  bool readOnly = false,
}) => SizedBox(
    height: 60.h,
    child: Semantics(
      textField: true,
      label: hint,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: (val) {
          state?.didChange(val);
        },
        readOnly: readOnly,
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode() ? Colors.black : Colors.white,
          contentPadding: EdgeInsets.symmetric(
            vertical: 19.h,
            horizontal: 20.w,
          ),
          isDense: true,
          hintText: hint,
          prefixIconConstraints: BoxConstraints(maxWidth: 120.w),
          prefixIcon: suffix != null
              ? Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: IntrinsicWidth(child: suffix),
          )
              : null,
          errorStyle: const TextStyle(height: 0, fontSize: 0), // Hide default
        ),
      ),
    ),
  );
