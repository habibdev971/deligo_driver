import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/presentation/auth/widgets/text_field_with_title.dart';

import '../../../core/widgets/required_title.dart';

Widget dropdownFromBuilderWithTitle<T>(BuildContext context, {
  required String title,
  required String name,
  required List<DropdownMenuItem<T>> items,
  bool isLoading = false,
  bool isRequired = true,
  String? hintText,
  T? initialValue,
  List<String? Function(T?)>? validators,
  void Function(T?)? onChanged
}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      requiredTitle(context, title: title, isRequired: isRequired),
      Gap(8.h),
      FormBuilderDropdown<T>(
        name: name,
        initialValue: initialValue,
        items: items,
        onChanged: onChanged,
        hint: Text(hintText ?? '', style: context.bodyMedium?.copyWith(fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF687387),),),
        validator: FormBuilderValidators.compose(validators ?? []),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        dropdownColor: context.surface,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          border: border(),
          enabledBorder: border(),
          focusedBorder: border(true),
          suffixIcon: isLoading ? const Center(child: CircularProgressIndicator(color: ColorPalette.primary50,)) : null
        ),
      ),
      Gap(16.h),
    ],
  );
