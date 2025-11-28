import 'dart:io';

import 'package:deligo_driver/core/routes/app_routes.dart';
import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
import 'package:deligo_driver/core/widgets/custom_dropdown.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/presentation/auth/provider/driver_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/core/widgets/required_title.dart';
import 'package:deligo_driver/presentation/auth/provider/auth_providers.dart';
import 'package:deligo_driver/presentation/auth/widgets/auth_app_bar.dart';
import 'package:deligo_driver/presentation/auth/widgets/text_field_with_title.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../../data/models/gender_model/gender_model.dart';
import '../../../generated/l10n.dart';
import '../widgets/auth_bottom_buttons.dart';
import '../widgets/image_picker_form_field.dart';

class DriverPersonalInfoPage extends ConsumerStatefulWidget {
  final String? phoneNumber;
  const DriverPersonalInfoPage({super.key, this.phoneNumber});

  @override
  ConsumerState<DriverPersonalInfoPage> createState() =>
      _ContactDetailsPageState();
}

class _ContactDetailsPageState extends ConsumerState<DriverPersonalInfoPage> {
  final formKey = GlobalKey<FormBuilderState>();
  File? profileImage;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final nationalityController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final taxNumberController = TextEditingController();
  final socialSecurityNumberController = TextEditingController();

  // final genderList = <GenderModel>[
  //   GenderModel(value: 'Male', name: AppLocalizations().gender_male),
  //   GenderModel(value: 'Female', name: AppLocalizations().gender_female),
  //   GenderModel(value: 'Other', name: AppLocalizations().gender_other),
  // ];
  // GenderModel? selectedGender;
  DateTime initialDate = DateTime.now().subtract(
    const Duration(days: 365 * 20),
  );

  @override
  void dispose() {
    emailController.dispose();
    addressController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    dateOfBirthController.dispose();
    nationalityController.dispose();
    taxNumberController.dispose();
    socialSecurityNumberController.dispose();
    // selectedGender = null;
    passwordController.dispose();
    initialDate = DateTime.now().subtract(const Duration(days: 365 * 20));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      backgroundColor: context.surface,
      body: AuthAppBar(
        title: localize(context).personal_info,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localize(context).add_driver_personal_info,
              style: context.bodyMedium?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode()
                    ? const Color(0xFF687387)
                    : const Color(0xFF24262D),
              ),
            ),
            Gap(8.h),
            Text(
              localize(context).enter_details_complete_profile,
              style: context.bodyMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF687387),
              ),
            ),
            Gap(24.h),
            FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  _buildFormFields(context),
                  imagePickerFormField(
                    context: context,
                    name: 'driverPhoto',
                    title: localize(context).profile_image,
                    initialFile: profileImage,
                    showImageSquare: false,
                    validator: (file) {
                      if (file == null) {
                        return localize(context).profile_image_required;
                      }
                      return null;
                    },
                    onChanged: (file) {
                      setState(() {
                        profileImage = file;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) => AuthBottomButtons(
          title: localize(context).next,
          isLoading: ref.watch(initialRegistrationProvider).whenOrNull(loading: ()=> true) ?? false,
          onTap: () async {
            if (formKey.currentState!.saveAndValidate()) {
              final formData = Map<String, dynamic>.from(formKey.currentState!.value)..addAll({
                  'isNewUser': false,
                  // 'phoneNumber': widget.phoneNumber
                  // ref
                  //     .watch(existingUserProvider)
                  //     .whenOrNull(success: (data) => data.data?.user?.phoneNumber),
                });
              ref.read(driverInfoProvider.notifier).updatePersonalInfo(formData);
              // final Map<String, dynamic> filteredData = {
              //   'firstName': formData['firstName'],
              //   'lastName': formData['lastName'],
              //   'email': formData['email'],
              //   'phoneNumber': formData['phoneNumber'] ?? '', // fallback if null
              //   'gender': (formData['gender'] as String).toUpperCase(),
              //   'userType': 'DRIVER', // fixed value
              // };
              // ref.read(driverInfoProvider.notifier).updatePersonalInfo()
              // ref.read(initialRegistrationProvider.notifier).initialRegistration(mapData: filteredData);
              NavigationService.pushNamed(AppRoutes.legalDocumentsPage);
    
            } else {
              showNotification(message: localize(context).all_field_required);
            }
          },
        ),
      ),
    ),
  );

  Widget _buildFormFields(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // _buildTextField(
      //   context,
      //   title: localize(context).first_name,
      //   controller: firstNameController,
      //   name: 'firstName',
      // ),
      // _buildTextField(
      //   context,
      //   title: localize(context).last_name,
      //   controller: lastNameController,
      //   name: 'lastName',
      // ),
      // _buildTextField(
      //   context,
      //   title: localize(context).phoneNo,
      //   controller: phoneController,
      //   name: 'phoneNumber',
      //   suffix: buildPhoneCodePickerButton()
      // ),
      _buildTextField(
        context,
        title: localize(context).date_of_birth,
        controller: dateOfBirthController,
        name: 'dateOfBirth',
        readOnly: true,
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: DateTime.now().subtract(const Duration(days: 365 * 90)),
            lastDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
          );
          if (picked != null) {
            initialDate = picked;
            dateOfBirthController.text = DateFormat(
              'yyyy-MM-dd',
              'en'
            ).format(picked);
            setState(() {});
          }
        },
      ),
      // _buildGenderDropdown(context),
      _buildTextField(
        context,
        title: localize(context).nationality,
        controller: nationalityController,
        name: 'nationality',
      ),
      _buildTextField(
        context,
        title: localize(context).address,
        controller: addressController,
        name: 'address',
      ),
      // _buildTextField(
      //   context,
      //   title: localize(context).email_label,
      //   controller: emailController,
      //   name: 'email',
      //   isEmail: true,
      // ),
      // _buildTextField(
      //   context,
      //   title: localize(context).password,
      //   controller: passwordController,
      //   name: 'password',
      // ),
      _buildTextField(
        context,
        title: localize(context).tax_number,
        controller: taxNumberController,
        name: 'nif',
        isNumber: true,
      ),
      _buildTextField(
        context,
        title: localize(context).social_security_number,
        controller: socialSecurityNumberController,
        name: 'security-number',
        isNumber: true,
      ),
    ],
  );

  Widget _buildTextField(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
    required String name,
    bool isEmail = false,
    bool isNumber = false,
    bool isRequired = true,
    bool readOnly = false,
    Function()? onTap,
        Widget? suffix,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: FormBuilderField(
      name: name,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        if (isEmail) FormBuilderValidators.email(),
        if (isNumber) FormBuilderValidators.numeric(),
      ]),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          requiredTitle(context, title: title, isRequired: isRequired),

          Gap(8.h),
          TextField(
            controller: controller,
            readOnly: readOnly,
            onTap: () async {
              // কীবোর্ড লুকাও
              if (onTap != null) await onTap(); // external tap handler

              field.didChange(controller.text);
            },
            keyboardType: isNumber
                ? TextInputType.number
                : isEmail
                ? TextInputType.emailAddress
                : null,
            onChanged: field.didChange,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              hintText: title,
              focusedBorder: border(true),
              enabledBorder: border(),
              border: border(),
              errorText: field.errorText,
              prefixIcon: suffix != null
                  ? Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: IntrinsicWidth(child: suffix),
              )
                  : null,
            ),

          ),
        ],
      ),
    ),
  );

  // Widget _buildGenderDropdown(BuildContext context, {bool isRequired = true}) {
  //   TextStyle? textStyle() => context.bodyMedium?.copyWith(
  //     fontSize: 16.sp,
  //     // fontWeight: FontWeight.w500,
  //     color: isDarkMode() ? Colors.white : Colors.black,
  //   );
  //   // Build gender list dynamically from localization
  //   // final genderItems = <DropdownMenuItem<String>>[
  //   //   DropdownMenuItem(
  //   //     value: 'Male',
  //   //     child: Text(
  //   //       localize(context).gender_male,
  //   //       style: context.bodyMedium?.copyWith(
  //   //         fontSize: 16.sp,
  //   //         fontWeight: FontWeight.w400,
  //   //         color: isDarkMode() ? Colors.white : Colors.black,
  //   //       ),
  //   //     ),
  //   //   ),
  //   //   DropdownMenuItem(
  //   //     value: 'Female',
  //   //     child: Text(
  //   //       localize(context).gender_female,
  //   //       style: context.bodyMedium?.copyWith(
  //   //         fontSize: 16.sp,
  //   //         fontWeight: FontWeight.w400,
  //   //         color: isDarkMode() ? Colors.white : Colors.black,
  //   //       ),
  //   //     ),
  //   //   ),
  //   //   DropdownMenuItem(
  //   //     value: 'Other',
  //   //     child: Text(
  //   //       localize(context).gender_other,
  //   //       style: context.bodyMedium?.copyWith(
  //   //         fontSize: 16.sp,
  //   //         fontWeight: FontWeight.w400,
  //   //         color: isDarkMode() ? Colors.white : Colors.black,
  //   //       ),
  //   //     ),
  //   //   ),
  //   // ];
  //
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 16),
  //     child: FormBuilderField<String>(
  //       name: 'gender',
  //       validator: FormBuilderValidators.required(
  //         errorText: localize(context).gender_required,
  //       ),
  //       initialValue: selectedGender?.value,
  //       autovalidateMode: AutovalidateMode.onUserInteraction,
  //       builder: (field) => Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           requiredTitle(
  //             context,
  //             title: localize(context).gender_label,
  //             isRequired: isRequired,
  //           ),
  //           Gap(8.h),
  //           customDropdown<String>(
  //             context,
  //             value: field.value,
  //             hint: AppLocalizations.of(context).gender,
  //             contentPadding: const EdgeInsets.symmetric(),
  //             items: [
  //               DropdownMenuItem(
  //                 value: 'Male',
  //                 child: Text(AppLocalizations.of(context).male, style: textStyle()),
  //               ),
  //               DropdownMenuItem(
  //                 value: 'Female',
  //                 child: Text(AppLocalizations.of(context).female, style: textStyle()),
  //               ),
  //               DropdownMenuItem(
  //                 value: 'Other',
  //                 child: Text(AppLocalizations.of(context).other, style: textStyle()),
  //               ),
  //             ],
  //             onChanged: (value) {
  //               setState(() {
  //                 selectedGender = GenderModel(value: value!, name: '');
  //               });
  //               field.didChange(value);
  //             },
  //
  //             menuPadding: EdgeInsets.only(left: 16.w),
  //           ),
  //           // DropdownButtonFormField<String>(
  //           //   initialValue: field.value,
  //           //   hint: Text(
  //           //     localize(context).gender_select,
  //           //     style: context.bodyMedium?.copyWith(
  //           //       fontSize: 16.sp,
  //           //       fontWeight: FontWeight.w400,
  //           //       color: const Color(0xFF687387),
  //           //     ),
  //           //   ),
  //           //   dropdownColor: context.surface,
  //           //   decoration: InputDecoration(
  //           //     contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
  //           //     focusedBorder: border(true),
  //           //     enabledBorder: border(),
  //           //     border: border(),
  //           //     errorText: field.errorText,
  //           //   ),
  //           //   items: genderItems,
  //           //   onChanged: (value) {
  //           //     setState(() {
  //           //       selectedGender = GenderModel(value: value!, name: '');
  //           //     });
  //           //     field.didChange(value);
  //           //   },
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

enum Gender { male, female, unknown }

final selectedGenderProvider = StateProvider<Gender>((ref) => Gender.male);
