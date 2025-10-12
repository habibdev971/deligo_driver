import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/widgets/required_title.dart';
import 'custom_dropdown.dart';

Widget dropdownWithTitle<T>(
  BuildContext context, {
  required String title,
  // required String name,
  required List<DropdownMenuItem<T>> items,
  bool isLoading = false,
  bool isRequired = true,
  String? hintText,
  T? initialValue,
  String? Function(T?)? validator,
  void Function(T?)? onChanged,
  double bottomPadding = 16,
}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      requiredTitle(context, title: title, isRequired: isRequired),
      Gap(8.h),
      customDropdown<T>(
        context,
        hint: hintText,
        value: initialValue,
        items: items,
        onChanged: onChanged,
        isLoading: isLoading,
        validator: validator,
        autoValidateMode: validator == null ? null : AutovalidateMode.onUserInteraction,

      ),
      Gap(bottomPadding.h),
    ],
  );
