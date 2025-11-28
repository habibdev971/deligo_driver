import 'dart:developer';

import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/widgets/custom_dropdown/dropdown_from_builder.dart';
import 'package:deligo_driver/data/models/auth_models/driver_dropdown_model_data/driver_dropdown_model.dart';
import 'package:deligo_driver/presentation/auth/widgets/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/build_network_image.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../../core/utils/localize.dart';
import '../../../data/services/url_launch_services.dart';
import '../provider/auth_providers.dart';
import '../provider/driver_info_provider.dart';
import '../widgets/auth_bottom_buttons.dart';
import '../widgets/form_text_field.dart';

class BankInfoPage extends ConsumerStatefulWidget {
  const BankInfoPage({super.key});

  @override
  ConsumerState<BankInfoPage> createState() => _BankInfoPageState();
}

class _BankInfoPageState extends ConsumerState<BankInfoPage> {
  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController iban = TextEditingController();
  PaymentMethods? selectedPaymentMethod;

  @override
  void dispose() {
    super.dispose();
    iban.dispose();
  }

  DriverDropdownData? gerDropDownData() => ref
      .watch(driverDropdownProvider)
      .whenOrNull(success: (data) => data.data);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: context.surface,
      body: AuthAppBar(
        title: localize(context).bank_info,
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: [
              Text(
                // localize(context).add_driver_documents,
                localize(context).add_bank_info,
                style: context.bodyMedium?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode()
                      ? const Color(0xFF687387)
                      : const Color(0xFF24262D),
                ),
              ),
              Gap(8.h),
              textFieldFromBuilderWithTitle(
                context,
                title: localize(context).iban,
                name: 'iban',
                hintText: localize(context).enter_iban,
                controller: iban,
              ),

              dropdownWithTitle<PaymentMethods>(
                context,
                  title: localize(context).payout_method,
                  hintText: localize(context).select_payment_method,
                  // name: 'categoryId',
                  items: gerDropDownData()?.paymentMethods?.map(
                        (e) => DropdownMenuItem<PaymentMethods>(
                      value: e,
                      child: Row(
                        children: [
                          buildNetworkImage(imageUrl: e.logo, height: 20, width: 20, errorIconSize: 20),
                          Gap(8.w),
                          Flexible(child: Text(
                            e.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyMedium?.copyWith(fontSize: 15.sp),
                          ))
                        ],
                      ),
                    ),
                  ).toList() ?? [],
                  validator: FormBuilderValidators.required(),
                  isLoading: ref.watch(driverDropdownProvider).whenOrNull(loading: () => true) ?? false,
                  // (value)
                  onChanged: (value){
                    if(value != null){
                      selectedPaymentMethod = value;
                      setState(() {});
                    }
                  }
              ),
              // ✅ 1. Confirm Information
              FormBuilderCheckbox(
                name: 'confirm_info',
                title: Text(
                  localize(context).confirm_information_true,
                  style: TextStyle(fontSize: 14.sp),
                ),
                validator: FormBuilderValidators.equal(
                  true,
                  errorText: localize(context).must_confirm_information,
                ),
              ),

              // ✅ 2. Terms & Conditions
              FormBuilderCheckbox(

                name: 'agreeToTerms',
                title: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      localize(context).i_agree_to,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          UrlLaunchServices.launchUrls('https://deligoeu.com/term.html');
                          // 👉 এখানে তুমি Terms & Conditions পেজে যেতে পারো
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => TermsPage()));
                        },
                        child: Text(
                          localize(context).deliGo_ride_terms,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                validator: FormBuilderValidators.equal(
                  true,
                  errorText: localize(context).must_agree_terms,
                ),
              ),

              // ✅ 3. GDPR Consent
              FormBuilderCheckbox(
                name: 'consentToDataProcessing',
                title: Text(
                  localize(context).consent_data_processing,
                  style: TextStyle(fontSize: 14.sp),
                ),
                validator: FormBuilderValidators.equal(
                  true,
                  errorText: localize(context).must_provide_gdpr_consent,
                ),
              ),

              Gap(8.h),
            ],
          ),
        )
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) => AuthBottomButtons(
          title: localize(context).submit,
          isLoading: ref.watch(registrationProvider).whenOrNull(loading: () => true) ?? false,
          onTap: () async {
            if (formKey.currentState!.saveAndValidate()) {
              // final formData = Map<String, dynamic>.from(formKey.currentState!.value);
              final formData = {
                'iban': iban.text,
                'bankName': selectedPaymentMethod?.name,
                'confirm_info': true,
                'agreeToTerms': true,
                'consentToDataProcessing': true,
              };
              log(formData.toString());
              ref.read(driverInfoProvider.notifier).updateBankPaymentInfo(formData);
              
              ref.read(registrationProvider.notifier).registration();
            } else {
              showNotification(message: localize(context).all_field_required);
            }
          },
        ),
      ),
    );
}
