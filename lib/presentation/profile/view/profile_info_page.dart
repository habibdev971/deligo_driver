import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/common/loading_view.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/core/widgets/buttons/app_back_button.dart';
import 'package:deligo_driver/core/widgets/error_view.dart';
import 'package:deligo_driver/presentation/profile/provider/profile_providers.dart';

import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../../data/models/user_model/user_model.dart';
import '../../auth/provider/auth_providers.dart';
import '../widgets/avatar_select_button.dart';

class ProfileInfoPage extends ConsumerStatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  ConsumerState<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends ConsumerState<ProfileInfoPage> {
  final _formKey = GlobalKey<FormState>();

  final genderItems = ['Male', 'Female', 'Other']
      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
      .toList();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      ref.read(selectedProfilePhotoProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    // nameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      final File? file = ref.watch(selectedProfilePhotoProvider);
      ref.read(updateProfileProvider.notifier)
      .updateProfile(

        data: {
          'firstName': firstNameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'phoneNumber': mobileController.text.trim(),
          'email': emailController.text.trim(),
          'gender': selectedGender?.capitalize(),
          'picture': file
        },

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(driverDetailsNotifierProvider);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
        backgroundColor: isDarkMode() ? Colors.black : Colors.white,
        leading: const AppBackButton(),
        title: Text(
          localize(context).my_profile,
          style: context.bodyMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: isDarkMode() ? Colors.white : const Color(0xFF24262D),
          ),
        ),
        centerTitle: false,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 8.h,
              width: double.infinity,
              color: isDarkMode() ? Colors.black12 : const Color(0xFFF6F7F9),
            ),

            state.when(initial: ()=> const SizedBox.shrink(), loading: ()=> const LoadingView(), success: (data){
              final user = data.data;

                // nameController.text = user?.fullName ?? '';
                firstNameController.text = user?.firstName ?? '';
                lastNameController.text = user?.lastName ?? '';
                mobileController.text = user?.phoneNumber ?? '';
                emailController.text = user?.email ?? '';
                selectedGender = user?.userInfo?.gender?.capitalize();


              return Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    color: isDarkMode() ? Colors.black : Colors.white,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AvatarSelectButton(avatarPath: user?.userInfo?.fullPictureUrl, ref: ref),
                          Gap(16.h),
                          _buildTextField(context, title: localize(context).first_name, controller: firstNameController),
                          Gap(16.h),
                          _buildTextField(context, title: localize(context).last_name, controller: lastNameController),
                          Gap(16.h),
                          _buildTextField(context, title: localize(context).mobile_number, controller: mobileController),
                          Gap(16.h),
                          _buildTextField(context, title: localize(context).email, controller: emailController),
                          Gap(16.h),
                          Text(
                            localize(context).gender,
                            style: context.bodyMedium?.copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode() ? const Color(0xFF687387) : const Color(0xFF24262D),
                            ),
                          ),
                          Gap(12.h),
                          FormBuilderDropdown<String>(
                            name: 'gender',
                            initialValue: selectedGender,
                            items: genderItems,
                            hint: Text(localize(context).gender, style: context.bodyLarge),
                            style: context.bodyMedium?.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF687387),
                            ),
                            dropdownColor: context.surface,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                            value == null ? localize(context).gender_required : null,
                            onChanged: (value) {
                              selectedGender = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }, error: (e)=> ErrorView(message: e.message)),

            Container(
              padding: EdgeInsets.all(12.r),
              width: double.infinity,
              color: isDarkMode() ? Colors.black : Colors.white,
              child: AppPrimaryButton(
                isLoading: ref.watch(updatePersonalInfoProvider).whenOrNull(loading: ()=> true) ?? false,
                isDisabled: ref.watch(updatePersonalInfoProvider).whenOrNull(loading: ()=> true) ?? false,
                onPressed: _saveProfile,
                child: Text(
                  localize(context).save,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildTextField(
      BuildContext context, {
        required String title,
        required TextEditingController controller,
      }) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.bodyMedium?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode() ?const Color(0xFF687387) : const Color(0xFF24262D),
          ),
        ),
        Gap(12.h),
        TextFormField(
          controller: controller,
          style: context.bodyMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF687387),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) =>
          (value == null || value.trim().isEmpty) ? localize(context).field_required : null,
        ),
      ],
    );


}
