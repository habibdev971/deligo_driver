import 'package:deligo_driver/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'custom_text_field.dart';
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
  // bool visibleEmail = false,
      bool? isPhoneReadable,
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
        // loginPage && visibleEmail ? const SizedBox.shrink() :
        textField(
          context,
          emailController,
          hint: loginPage
              ? AppLocalizations.of(context).email_or_phone
              : AppLocalizations.of(context).email,
          keyboardType: TextInputType.emailAddress,
          emailOrPhoneEnable: loginPage,
          readOnly: isPhoneReadable == false,
        ),
        // loginPage
        //     ? const SizedBox.shrink()
        //     :
          Visibility(
            visible: !loginPage ,
            child: textField(
                  context,
                  phoneController,
                  hint: AppLocalizations.of(context).phoneNo,
                  keyboardType: TextInputType.phone,
                  readOnly: isPhoneReadable == true,
                  // suffix:
                  // suffix: buildPhoneCodePickerButton(),
                ),
          ),
        // loginPage
        //     ? textField(
        //         context,
        //         passwordController,
        //         hint: AppLocalizations.of(context).password,
        //         keyboardType: TextInputType.visiblePassword,
        //       )
        //     : const SizedBox.shrink(),
        loginPage
            ? const SizedBox.shrink()
            : genderDropdown(context, genderController),
      ],
    ),
  );
