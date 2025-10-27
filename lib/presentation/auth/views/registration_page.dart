import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/presentation/account_page/provider/select_country_provider.dart';
import 'package:deligo_driver/presentation/auth/widgets/auth_app_bar.dart';
import 'package:deligo_driver/presentation/auth/widgets/auth_bottom_buttons.dart';
import 'package:deligo_driver/presentation/auth/widgets/register_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_providers.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    genderController.dispose();
  }

  @override
  Widget build(BuildContext context) => ExitAppWrapper(

      child: Scaffold(
        body: AuthAppBar(
          title: 'Register',
          // showLeading: true,
          child: Form(
              key: _formKey,
              child: registrationLoginFields(context, firstNameController: firstNameController, lastNameController: lastNameController, emailController: emailController, phoneController: phoneController, passwordController: passwordController, genderController: genderController, loginPage: false)),
        ),
        bottomNavigationBar: Consumer(builder: (context, ref, _){
          final notifier = ref.read(initialRegistrationProvider.notifier);
          String phoneCode = ref.watch(selectedPhoneCodeProvider);
          phoneCode = phoneCode.contains('+880') ? phoneCode.replaceAll('0', '') : phoneCode;
          // final String number = phoneCode + phoneController.text.trim();
          return AuthBottomButtons(
            isLoading: ref.watch(initialRegistrationProvider).whenOrNull(loading: ()=> true) ?? false,
            title: localize(context).confirm, onTap: () {
              if(phoneController.text.trim().isEmpty){
                showNotification(message: 'invalid phone');
                return;
              }
            if(_formKey.currentState!.validate()){
              _formKey.currentState!.save();
              notifier.initialRegistration(mapData: {
                'firstName': firstNameController.text.trim(),
                'lastName': lastNameController.text.trim(),
                'email': emailController.text.trim(),
                'phoneNumber': phoneCode + phoneController.text.trim(),
                'gender': genderController.text.toUpperCase(),
                'userType': 'DRIVER'
              });
            }
          },);
        }),
      ),
    );
}
