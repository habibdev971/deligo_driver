import 'package:flutter/material.dart';

import '../../../core/widgets/custom_text_field.dart';
import '../../../generated/l10n.dart';
import '../../account_page/widgets/phone_code_picker_button.dart';
import 'gender_dropdown.dart';

Widget registrationLoginFields(
    BuildContext context, {
      required TextEditingController firstNameController,
      required TextEditingController lastNameController,
      required TextEditingController emailController,
      required TextEditingController phoneController,
      required TextEditingController passwordController,
      required TextEditingController genderController,
      bool loginPage = false,
    }) => Semantics(
    label: loginPage
        ? AppLocalizations.of(context).sign_in_form_fields
        : AppLocalizations.of(context).registration_form_fields,
    child: Column(
      children: [
        loginPage
            ? const SizedBox.shrink()
            : textField(
          context,
          firstNameController,
          hint: AppLocalizations.of(context).first_name,
          keyboardType: TextInputType.name,
        ),
        loginPage
            ? const SizedBox.shrink()
            : textField(
          context,
          lastNameController,
          hint: AppLocalizations.of(context).last_name,
          keyboardType: TextInputType.name,
        ),
        textField(
          context,
          emailController,
          hint: loginPage
              ? AppLocalizations.of(context).email_or_phone
              : AppLocalizations.of(context).email,
          keyboardType: TextInputType.emailAddress,
          emailOrPhoneEnable: loginPage,
        ),
        loginPage
            ? const SizedBox.shrink()
            : textField(
          context,
          phoneController,
          hint: AppLocalizations.of(context).phoneNo,
          keyboardType: TextInputType.phone,
          suffix: buildPhoneCodePickerButton(),
        ),
        loginPage
            ? textField(
          context,
          passwordController,
          hint: AppLocalizations.of(context).password,
          keyboardType: TextInputType.visiblePassword,
        )
            : const SizedBox.shrink(),
        loginPage
            ? const SizedBox.shrink()
            : genderDropdown(context, genderController),
      ],
    ),
  );
