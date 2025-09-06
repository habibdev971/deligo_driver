import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/theme/theme.typography.dart';

InputDecorationTheme inputTheme(String fontPrimary, String fontSecondary) =>
    InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      iconColor: ColorPalette.neutral70,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      prefixIconColor: ColorPalette.neutral70,
      suffixIconColor: ColorPalette.neutral70,

      hintStyle: textTheme(fontPrimary, fontSecondary).bodyLarge,
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: const Color(0xFFD7DAE0),
          width: 1.w
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: const Color(0xFFD7DAE0),
          width: 1.w
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(
          color: ColorPalette.primary50,
          width: 1.w
        ),
      ),
    );
