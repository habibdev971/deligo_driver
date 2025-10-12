import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/routes/app_routes.dart';
import 'package:deligo_driver/core/utils/app_colors.dart';
import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/widgets/buttons/app_primary_button.dart';
import 'package:deligo_driver/core/widgets/otp_textfield.dart';
import 'package:deligo_driver/data/services/firebase_auth_service.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/widgets/app_bar/app_bar.dart';
import '../../../data/models/auth_models/register_data_model.dart';
import '../widgets/resend_otp.dart';

class FirebaseOtpPage extends ConsumerStatefulWidget {
  final String? phoneNumber;
  const FirebaseOtpPage({super.key, this.phoneNumber});

  @override
  ConsumerState<FirebaseOtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<FirebaseOtpPage> {
  TextEditingController otpController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   if(widget.otp != null){
  //     otpController.text = widget.otp.toString();
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }

  void verifyOtp() {
    final otp = otpController.text.trim();

    if (otp.length != 6 || int.tryParse(otp) == null) {
      showNotification(message: AppLocalizations.of(context).enter_otp_fields);
      return;
    } else {
      final loading = ref.read(authLoadingProvider.notifier);

      firebaseAuthNotifier.value.verifyOTP(
        otp,
        onLoadingChange: (val) => loading.state = val,
        onSuccess: () {
          NavigationService.pushNamed(AppRoutes.driverPersonalInfoPage, arguments: widget.phoneNumber);
          // loading.state = true;
          // final data = widget.data;
          // if (data == null) {
          //   showNotification(message: 'Register again');
          //   return;
          // }
          // ref
          //     .read(registrationProvider.notifier)
          //     .registration(
          //       mobile: widget.data!.phoneNumber,
          //       email: widget.data!.email,
          //       firstName: widget.data!.firstName,
          //       lastName: widget.data!.lastName,
          //       gender: widget.data!.gender,
          //       onSuccess: () {
          //         loading.state = false;
          //       },
          //     );
        },
      );
      // ref.read(otpVerifyProvider.notifier).verifyOTP(mobile: widget.mobile ?? '', otp: otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authLoadingProvider);

    return ExitAppWrapper(
      child: Scaffold(
        appBar: mainAppBar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppPrimaryButton(
            isLoading: isLoading,
            isDisabled: isLoading,
            onPressed: verifyOtp,
            child: Text(
              AppLocalizations.of(context).verify,
              style: context.bodyMedium,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Gap(30.h),
              Text(
                AppLocalizations.of(context).phone_verification,
                style: context.bodyMedium?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode() ? Colors.white : AppColors.textSecondary,
                ),
              ),
              Gap(12.h),
              Text(
                AppLocalizations.of(context).enter_otp_code,
                style: context.bodyMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.neutral,
                ),
              ),
              Gap(40.h),
              Semantics(
                label: AppLocalizations.of(context).enter_otp_fields,
                child: Row(
                  children: [
                    Expanded(
                      child: OtpTextField(
                        length: 6,
                        otpController: otpController,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(20.h),
              resendOtp(context, phoneNumber: widget.phoneNumber ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
