import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../account_page/widgets/phone_code_picker_button.dart';
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
      void Function(String? v)? onChange,
      bool showCountryCode = false,
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
          hint:
          loginPage && showCountryCode
              ? AppLocalizations.of(context).phoneNo
              :
          AppLocalizations.of(context).email,
          keyboardType: loginPage && showCountryCode ? TextInputType.phone : TextInputType.emailAddress,
          emailOrPhoneEnable: loginPage,
          hideValidator: loginPage == false,
          // readOnly: isPhoneReadable == false,
          onChange: loginPage ? onChange : null,
          suffix: loginPage && showCountryCode ? buildPhoneCodePickerButton() : const Icon(Icons.email, color: ColorPalette.primary50,),
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
                  suffix: loginPage ? null : buildPhoneCodePickerButton(),
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
