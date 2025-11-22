import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget usePreferMethod(
  BuildContext context, {
  required bool loginWithPhone,
  required void Function() onTap,
  required bool visible
}) => Visibility(
  visible: visible,
  child: ListTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
      side: const BorderSide(color: ColorPalette.primary50)
    ),
    leading: Icon(
      loginWithPhone ? Icons.email : Icons.phone,
      color: ColorPalette.primary50,
    ),
    title: Text(
      loginWithPhone ? 'Use Email Instead' : 'Use Phone Instead',
      style: context.bodyMedium,
    ),
    onTap: onTap,
  ),
);
