import 'package:deligo_driver/presentation/auth/views/registration_login_page/widget/registration_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/exit_app_dialogue.dart';
import '../../../../../core/widgets/app_bar/app_bar.dart';
import '../../../../../gen/assets.gen.dart';
import '../widget/have_account_login_sign_up.dart';
import '../widget/registration_top.dart';
import '../widget/sign_up_button.dart';
import '../widget/social_logins.dart';
import '../widget/terms_and_condition.dart';

/// whenever navigate to loginSignup page must send argument as follows
/// {"isLoginPage": true/false, "phone": "+8801234567890" nullable, "email": "william.rufus.day@example-pet-store.com" nullable}
/// for copy pest use {"isLoginPage": true}
class LoginSignUpPage extends StatefulWidget {
  final bool isLoginPage;
  final String? phoneNumber;
  final String? email;

  const LoginSignUpPage({
    super.key,
    required this.isLoginPage,
    this.phoneNumber,
    this.email,
  });

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final genderController = TextEditingController();

  bool isTermsAndServiceSelected = true;
  bool? isPhoneReadable;

  @override
  void initState() {
    super.initState();

    // CASE: Coming from OTP page → prefill email/phone for registration
    if (!widget.isLoginPage) {
      if (widget.phoneNumber != null) {
        isPhoneReadable = true;
        phoneController.text = widget.phoneNumber!;
      } else if (widget.email != null) {
        isPhoneReadable = false;
        emailController.text = widget.email!;
      }
    }


  WidgetsBinding.instance.addPostFrameCallback((_) {
    setState(() {

    });
  });
      }
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    genderController.dispose();
    super.dispose();
  }

  void _toggleTerms() {
    setState(() {
      isTermsAndServiceSelected = !isTermsAndServiceSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLogin = widget.isLoginPage;

    return ExitAppWrapper(
      child: Scaffold(
        appBar: mainAppBar(context, hideLeading: widget.isLoginPage),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gap(14.h),

                  /// TOP TITLE
                  registrationTop(context, loginPage: isLogin),
                  Visibility(
                      visible: isLogin,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Assets.images.signIn.image(height: 163.h, width: 163.w),
                      )),
                  /// INPUT FIELDS
                  registrationLoginFields(
                    context,
                    loginPage: isLogin,
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    emailController: emailController,
                    phoneController: phoneController,
                    passwordController: passwordController,
                    genderController: genderController,
                    // visibleEmail: isLogin,
                    isPhoneReadable: isPhoneReadable,
                  ),

                  /// TERMS AND CONDITIONS
                  termsAndCondition(
                    context,
                    loginPage: isLogin,
                    onTap: _toggleTerms,
                    isSelected: isTermsAndServiceSelected,
                  ),

                  /// LOGIN / SIGNUP BUTTON
                  loginSignUpButton(
                    context,
                    formKey: _formKey,
                    loginPage: isLogin,
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    emailController: emailController,
                    phoneController: phoneController,
                    passwordController: passwordController,
                    genderController: genderController,
                    loginWithEmail: false,
                    isTermsAndServiceSelected: isTermsAndServiceSelected,
                    isPhoneReadable: isPhoneReadable,
                  ),

                  Gap(32.h),

                  /// ALREADY HAVE ACCOUNT → LOGIN or SIGNUP
                  alreadyHaveAccountLoginSignUp(
                    context,
                    loginPage: isLogin,
                  ),

                  Gap(20.h),

                  /// SOCIAL LOGIN BUTTONS
                  socialLogin(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
