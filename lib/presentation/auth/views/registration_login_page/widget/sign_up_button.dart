import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/buttons/app_primary_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../account_page/provider/select_country_provider.dart';
import '../../../provider/auth_providers.dart';

Widget loginSignUpButton(
    BuildContext context, {
      required GlobalKey<FormState> formKey,
      bool loginPage = false,
      required TextEditingController firstNameController,
      required TextEditingController lastNameController,
      required TextEditingController emailController,
      required TextEditingController phoneController,
      required TextEditingController passwordController,
      required TextEditingController genderController,
      bool loginWithEmail = false,
      required bool isTermsAndServiceSelected,
      bool? isPhoneReadable,
    }) {
  final isLogin = loginPage;
  return Consumer(
    builder: (context, ref, _) {
      final isLoading = isLogin ? (ref.watch(existingUserProvider).whenOrNull(loading: ()=> true) ?? false) : (ref.watch(initialRegistrationProvider).whenOrNull(loading: ()=> true) ?? false);

      return Semantics(
            button: true,
            label: '${isLogin
                ? AppLocalizations.of(context).sign_in
                : AppLocalizations.of(context).sign_up} ${AppLocalizations.of(context).button}',
            hint: AppLocalizations.of(context).double_tap_create_account,
            child: AppPrimaryButton(
              isDisabled: isLoading,
              isLoading: isLoading,
              onPressed: () async {
                final bool? isValid = formKey.currentState?.validate();
                if (isValid == true) {
                  final String phoneCode = '';

                  if (isLogin) {
                    final String input = emailController.text.trim();


                    bool isEmail(String value) => RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@"
                          r'[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?'
                          r'(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'
                      ).hasMatch(value);

                    bool isPhone(String value) {
                      final String cleaned = value.replaceAll(RegExp(r'[^\d+]'), '');
                      return RegExp(r'^\+?\d{7,15}$').hasMatch(cleaned);
                    }

                    if (isEmail(input)) {
                      debugPrint('Email detected $input');
                    } else if (isPhone(input)) {
                      // input = mergePhoneNumber(input, ref.watch(selectedPhoneCodeProvider));
                      debugPrint('Phone number detected $input');
                    } else {
                      debugPrint('Invalid input $input');
                      showNotification(message: 'Invalid input neither phone number nor email');
                      return;
                    }

                    ref.read(existingUserProvider.notifier).checkExistenceUser(phoneOrEmail: input, countryCode: phoneCode, isPhoneNumber: isPhone(input),);

                  } else {
                    if(!isTermsAndServiceSelected){
                      showNotification(message: 'You Have to agree with terms and service');
                      return;
                    }
                    ref.read(initialRegistrationProvider.notifier)
                        .initialRegistration(
                        mobile: mergePhoneNumber(phoneController.text.trim(), ref.watch(selectedPhoneCodeProvider)),
                        email: emailController.text.trim(),
                        firstName: firstNameController.text.trim(),
                        lastName: lastNameController.text.trim(),
                        gender: genderController.text.trim(),
                        sendOtpToPhone: isPhoneReadable
                        // onSuccess: (){
                        //   loading.state = false;
                        // }
                    );

                  }
                }
              },
              title: isLogin
                  ? AppLocalizations.of(context).sign_in
                  : AppLocalizations.of(context).sign_up,
            ),
          );
    }
  );
}

String mergePhoneNumber(String rawNumber, String selectedCode) {
  String number = rawNumber.trim();

  // Clean spaces, dashes etc.
  number = number.replaceAll(RegExp(r'[^\d+]'), '');

  // Check if number already contains a valid country code
  final bool hasCountryCode = RegExp(r'^\+\d{1,3}').hasMatch(number);

  // If already has country code → return as is
  if (hasCountryCode) {
    return number;
  }

  // If selected code is Bangladesh +880, fix leading 0 issue
  if (selectedCode.contains('+880')) {
    selectedCode = '+88'; // Remove auto zero
  }

  return selectedCode + number;
}
