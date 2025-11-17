import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget textFieldOnly({
  String? hint,
  Widget? suffix,
  Widget? prefix,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
  TextEditingController? controller,
  FormFieldState<String>? state,
  bool readOnly = false,
  bool obscureText = false,
  void Function()? onTap,
  void Function(String? v)? onChange,
}) => SizedBox(
    height: 60.h,
    child: Semantics(
      textField: true,
      label: hint,
      child: TextField(
        controller: controller,
        onTap: onTap,
        keyboardType: keyboardType,
        onChanged: (val) {
          state?.didChange(val);
          onChange != null ? onChange(val) : null;
        },
        readOnly: readOnly,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: isDarkMode() ? Colors.black : Colors.white,
          contentPadding: EdgeInsets.symmetric(
            vertical: 19.h,
            horizontal: 20.w,
          ),
          isDense: true,
          hintText: hint,
          suffixIcon: prefix,
          prefixIconConstraints: BoxConstraints(minWidth: 0, maxWidth: 120.w),
          prefixIcon: suffix != null
              ? Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: IntrinsicWidth(child: suffix),
                )
              : null,
          errorText: null, // Prevents native shifting
          errorStyle: const TextStyle(height: 0, fontSize: 0), // Hide default
        ),
      ),
    ),
  );
