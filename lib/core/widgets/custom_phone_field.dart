// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:gap/gap.dart';
// import 'package:deligo_driver/core/extensions/extensions.dart';
// import 'package:deligo_driver/core/utils/localize.dart';
//
// import '../../presentation/account_page/provider/select_country_provider.dart';
// import 'country_code_bottom_sheet.dart';
//
// class AppPhoneNumberTextField extends StatelessWidget {
//   final void Function(String?)? onChanged;
//   final String? initialValue;
//   final bool isDark;
//   const AppPhoneNumberTextField({
//     super.key,
//     required this.initialValue,
//     this.onChanged, required this.isDark,
//   });
//
//   @override
//   Widget build(BuildContext context) => Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       build
//       Gap(8.w),
//       Expanded(
//         child: SizedBox(
//           height: 48.h,
//           child: FormBuilderTextField(
//             name: 'phoneNumber',
//             keyboardType: TextInputType.phone,
//             inputFormatters: [
//               FilteringTextInputFormatter.digitsOnly,
//             ],
//             initialValue: initialValue,
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(),
//               FormBuilderValidators.min(6),
//             ]),
//             decoration:  InputDecoration(
//                 hintText: localize(context).enterPhoneNumber,
//                 fillColor: context.surface,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h)
//             ),
//             onChanged: onChanged,
//           ),
//         ),
//       )
//     ],
//   );
// }