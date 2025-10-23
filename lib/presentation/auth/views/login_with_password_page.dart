import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/presentation/auth/provider/auth_providers.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/utils/exit_app_dialogue.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../generated/l10n.dart';
import '../../account_page/widgets/phone_code_picker_button.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_bottom_buttons.dart';

class LoginWithPasswordPage extends ConsumerStatefulWidget {
  const LoginWithPasswordPage({super.key});

  @override
  ConsumerState<LoginWithPasswordPage> createState() =>
      _LoginWithPasswordPageState();
}

class _LoginWithPasswordPageState extends ConsumerState<LoginWithPasswordPage> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  // bool codeLengthIsSafe = false;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      backgroundColor: context.surface,
      body: AuthAppBar(
        title: localize(context).password_label,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localize(context).login_with_your_password,
              style: context.bodyMedium?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode()
                    ? const Color(0xFF687387)
                    : ColorPalette.neutral24,
              ),
            ),
            Gap(8.h),
            Text(
              localize(context).use_your_password_here,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: const Color(0xFF687387),
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(24.h),

            Text(
              localize(context).phoneNo,
              style: context.bodyMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDarkMode()
                    ? const Color(0xFF687387)
                    : const Color(0xFF24262D),
              ),
            ),
            Gap(12.h),
            textField(
              context,
              phoneController,
              hint: AppLocalizations.of(context).phoneNo,
              keyboardType: TextInputType.phone,
              suffix: buildPhoneCodePickerButton(),
            ),
            Text(
              localize(context).password_label,
              style: context.bodyMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: isDarkMode()
                    ? const Color(0xFF687387)
                    : const Color(0xFF24262D),
              ),
            ),
            Gap(12.h),
            textField(
              context,
              passwordController,
              hint: localize(context).password_label,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !showPassword,
              suffix: CupertinoButton(
                onPressed: () => setState(() => showPassword = !showPassword),
                child: Icon(
                  showPassword ? Ionicons.eye : Ionicons.eye_off,
                  color: context.theme.inputDecorationTheme.suffixIconColor,
                ),
              ),
            ),
            // TextField(
            //   controller: passwordController,
            //   onChanged: (v) {
            //     setState(() {
            //       codeLengthIsSafe = v.length >= 6 && v.length <= 16;
            //     });
            //   },
            //   obscureText: !showPassword,
            //   decoration: InputDecoration(
            //     hintText: localize(context).password_label,
            //     suffixIcon: CupertinoButton(
            //       onPressed: () => setState(() => showPassword = !showPassword),
            //       child: Icon(
            //         showPassword ? Ionicons.eye : Ionicons.eye_off,
            //         color: context.theme.inputDecorationTheme.suffixIconColor,
            //       ),
            //     ),
            //   ),
            // ),
            Gap(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ", style: context.bodySmall,),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      NavigationService.pushNamed(AppRoutes.driverPersonalInfoPage);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )

            // Gap(16.h),
            //
            // Consumer(
            //   builder: (context, ref, _) {
            //     final resentOTPState = ref.watch(resendOTPNotifierProvider);
            //     final resentOTPNotifier = ref.read(
            //       resendOTPNotifierProvider.notifier,
            //     );
            //
            //     final existingUserData = ref
            //         .read(existingUserProvider)
            //         .maybeWhen(success: (data) => data, orElse: () => null);
            //
            //     return Center(
            //       child: AppTextButton(
            //         text: localize(context).use_otp_instead,
            //         isDisabled:
            //             resentOTPState.whenOrNull(loading: () => true) ?? false,
            //         onPressed: () async {
            //           await resentOTPNotifier.resendOtp(
            //             mobile: existingUserData?.data?.user?.phoneNumber ?? '',
            //             onSuccess: (v) {
            //               NavigationService.pushNamed(
            //                 AppRoutes.verifyOTP,
            //                 arguments: (v.data?.otp ?? '').toString(),
            //               );
            //             },
            //           );
            //         },
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),

      bottomNavigationBar: Consumer(
        builder: (context, ref, _) {
          final loginWithPassState = ref.watch(loginWithPhoneOrEmailProvider);
          final stateNotifier = ref.read(
            loginWithPhoneOrEmailProvider.notifier,
          );

          // final existingUserData = ref
          //     .read(existingUserProvider)
          //     .maybeWhen(success: (data) => data, orElse: () => null);

          return AuthBottomButtons(
            isLoading: (phoneController.text.length < 5 && passwordController.text.length < 5) || (loginWithPassState.whenOrNull(loading: () => true) ?? false),
            title: localize(context).login,
            onTap: () {
              if(phoneController.text.length > 6 && passwordController.text.length > 5){
                stateNotifier.loginWithPhoneOrEmail(
                  mobile: phoneController.text.trim(),
                  password: passwordController.text,
                );
              }else if(phoneController.text.length < 6){
                showNotification(message: 'Please enter a valid phone number');
              }else if(passwordController.text.length < 6) {
                showNotification(message: 'Please enter a valid password');
              }else{
                showNotification(message: 'Please enter a valid phone number and password');
              }
            },
          );
        },
      ),
    ),
  );
}
