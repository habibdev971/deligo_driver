import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/localize.dart';

import '../../../core/theme/color_palette.dart';
import '../../../core/utils/exit_app_dialogue.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../../core/widgets/custom_phone_field.dart';
import '../../../data/models/login_response/login_response.dart';
import '../../account_page/provider/select_country_provider.dart';
import '../provider/auth_providers.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/auth_bottom_buttons.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  String _phoneNumber = '';
  bool _isPhoneValid = false;

  void _onPhoneChanged(String? value) {
    if (value != null) {
      setState(() {
        _phoneNumber = value;
        _isPhoneValid = value.trim().length >= 6;
      });
    }
  }

  void _onSubmit() {
    if (!_isPhoneValid) {
      showNotification(message: localize(context).phoneMinLengthError);
      return;
    }

    final phoneCode = ref.read(selectedCountry).selectedCode!.phoneCode;
    ref.read(loginNotifierProvider.notifier).login(
      phone: _phoneNumber,
      countryCode: phoneCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);
    final isLoading = loginState.whenOrNull(loading: () => true, ) ?? false;
    final isDark = isDarkMode();
    return ExitAppWrapper(
      child: Scaffold(
        backgroundColor: context.surface,
        resizeToAvoidBottomInset: true,
        body: AuthAppBar(
          showLeading: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localize(context).helloText,
                style: context.bodyMedium?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.primary50,
                ),
              ),
              Gap(4.h),
              Text(
                localize(context).welcomeBack,
                style: context.bodyMedium?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? const Color(0xFF687387) : ColorPalette.neutral24,
                ),
              ),
              Gap(8.h),
              Text(
                localize(context).enterPhoneDes,
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
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF24262D),
                ),
              ),
              Gap(12.h),
              FormBuilder(
                key: _formKey,
                child: AppPhoneNumberTextField(

                  initialValue: '',
                  onChanged: _onPhoneChanged,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AuthBottomButtons(
          isLoading: isLoading,
          title: localize(context).loginSignup,
          onTap: _onSubmit,
        ),
      ),
    );
  }

  bool isNewDriver(LoginResponse response) => response.data?.isNewDriver ?? true;
}
