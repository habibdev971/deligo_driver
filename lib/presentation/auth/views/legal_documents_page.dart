import 'dart:io';

import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/routes/app_routes.dart';
import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/presentation/auth/widgets/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../../../core/utils/localize.dart';
import '../provider/driver_info_provider.dart';
import '../widgets/auth_bottom_buttons.dart';
import '../widgets/image_picker_form_field.dart';

class LegalDocumentsPage extends StatefulWidget {
  const LegalDocumentsPage({super.key});

  @override
  State<LegalDocumentsPage> createState() => _LegalDocumentsPageState();
}

class _LegalDocumentsPageState extends State<LegalDocumentsPage> {
  final formKey = GlobalKey<FormBuilderState>();
  File? citizenCard;
  File? drivingLicense;
  File? driverCertificate;
  File? criminalRecord;
  File? residencePermit;

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      body: AuthAppBar(
          title: localize(context).legal_documents,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localize(context).add_legal_documents,
                style: context.bodyMedium?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode()
                      ? const Color(0xFF687387)
                      : const Color(0xFF24262D),
                ),
              ),
              Gap(8.h),
              Text(
                localize(context).enter_legal_documents_to_complete_profile,
                style: context.bodyMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF687387),
                ),
              ),
              Gap(24.h),
              FormBuilder(
                  key: formKey,
                  child: Column(
                children: [
                  imagePickerFormField(
                    context: context,
                    name: 'citizenCard',
                    title: localize(context).citizen_card,
                    initialFile: citizenCard,
                    validator: (file) => file == null ? localize(context).field_required : null,
                    onChanged: (file) => setState(() => citizenCard = file),
                  ),
                  Gap(16.h),
                  imagePickerFormField(
                    context: context,
                    name: 'drivingLicense',
                    title: localize(context).driving_license,
                    initialFile: drivingLicense,
                    validator: (file) => file == null ? localize(context).field_required : null,
                    onChanged: (file) => setState(() => drivingLicense = file),
                  ),
                  Gap(16.h),
                  imagePickerFormField(
                    context: context,
                    name: 'tvdeCertificate',
                    title: localize(context).tvde_driver_certificate,
                    initialFile: driverCertificate,
                    validator: (file) => file == null ? localize(context).field_required : null,
                    onChanged: (file) => setState(() => driverCertificate = file),
                  ),
                  Gap(16.h),
                  imagePickerFormField(
                    context: context,
                    name: 'criminalRecordCertificate',
                    title: localize(context).criminal_record_certificate,
                    initialFile: criminalRecord,
                    isRequired: false,
                    validator: (v)=> null,
                    // validator: (file) => file == null ? localize(context).field_required : null,
                    onChanged: (file) => setState(() => criminalRecord = file),
                  ),
                  Gap(16.h),
                  imagePickerFormField(
                    context: context,
                    name: 'residencePermit',
                    title: localize(context).residence_permit_if_non_eu,
                    initialFile: residencePermit,
                    isRequired: false,
                    validator: (v)=> null,
                    // validator: (file) => file == null ? localize(context).field_required : null,
                    onChanged: (file) => setState(() => residencePermit = file),
                  ),
                  Gap(16.h),
                ],
              ),),
            ],
          )
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, _) => AuthBottomButtons(
          title: localize(context).next,
          onTap: () async {
            if (formKey.currentState!.saveAndValidate()) {
              final formData = Map<String, dynamic>.from(formKey.currentState!.value);
              ref.read(driverInfoProvider.notifier).updateLegalDocuments(formData);
              NavigationService.pushNamed(AppRoutes.vehicleInfoPage);
            } else {
              showNotification(message: localize(context).all_field_required);
            }
          },
        ),
      ),  ),
  );
}
