import 'dart:developer';
import 'dart:io';

import 'package:deligo_driver/core/routes/app_routes.dart';
import 'package:deligo_driver/core/utils/build_network_image.dart';
import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
import 'package:deligo_driver/core/widgets/custom_dropdown/dropdown_from_builder.dart';
import 'package:deligo_driver/data/models/auth_models/driver_dropdown_model_data/driver_dropdown_model.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/presentation/auth/provider/auth_providers.dart';
import 'package:deligo_driver/presentation/auth/widgets/auth_app_bar.dart';
import 'package:deligo_driver/presentation/auth/widgets/auth_bottom_buttons.dart';

import '../../../core/utils/helpers.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../provider/driver_info_provider.dart';
import '../widgets/dropdown_date_selector.dart';
import '../widgets/form_text_field.dart';
import '../widgets/image_picker_form_field.dart';

class VehicleInfoPage extends ConsumerStatefulWidget {
  const VehicleInfoPage({super.key});

  @override
  ConsumerState<VehicleInfoPage> createState() =>
      _DocumentUploadPageState();
}

class _DocumentUploadPageState extends ConsumerState<VehicleInfoPage> {
  final formKey = GlobalKey<FormBuilderState>();

  final TextEditingController plateNumberController = TextEditingController();
  final TextEditingController vehicleModelController = TextEditingController();
  final TextEditingController manufactureYearController =
      TextEditingController();

  VehicleTypes? selectedVehicleType;
  VehicleBrands? selectedVehicleBrand;
  VehicleColors? selectedVehicleColor;
  FuelTypes? selectedFuelType;
  GearTypes? selectedGearType;
  // DateTime? yearOfManufacture;
  File? inspectionCertificate;
  File? insuranceCertificate;
  File? registrationCertificate;
  //
  // File? drivingLicenseImage;
  // File? nidImage;
  // File? vehiclePapers;
  // int? vehicleType;
  // int? vehicleColor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _fetchData();
    });
  }

  @override
  void dispose() {
    plateNumberController.dispose();
    manufactureYearController.dispose();
    vehicleModelController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    // final colorNotifier = ref.read(carColorNotifierProvider.notifier);
    // final modelNotifier = ref.read(carModelNotifierProvider.notifier);
    final notifier = ref.read(driverDropdownProvider.notifier);

    await Future.wait([
      notifier.getDriverDropdownData(),
      // colorNotifier.getCarColors(),
      // modelNotifier.getCarModels(),
    ]);
  }

  DriverDropdownData? gerDropDownData() => ref
      .watch(driverDropdownProvider)
      .whenOrNull(success: (data) => data.data);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(driverDropdownProvider);
    final isLoading = state.whenOrNull(loading: () => true) ?? false;

    return ExitAppWrapper(
      child: Scaffold(
        backgroundColor: context.surface,
        body: AuthAppBar(
          title: localize(context).driver_documents,
          child: FormBuilder(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localize(context).add_driver_documents,
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
                  localize(context).upload_driver_documents,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF687387),
                  ),
                ),
                Gap(24.h),
                dropdownWithTitle<VehicleTypes>(
                  context,
                  title: localize(context).vehicle_type,
                  hintText: localize(context).select_vehicle_type,
                  // name: 'categoryId',
                  items: gerDropDownData()?.vehicleTypes?.map(
                    (e) => DropdownMenuItem<VehicleTypes>(
                      value: e,
                      child: Row(
                        children: [
                          buildNetworkImage(imageUrl: e.categoryImage, height: 20, width: 20, errorIconSize: 20),
                          Gap(8.w),
                          Flexible(child: Text(
                            e.categoryName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyMedium?.copyWith(fontSize: 15.sp),
                          ))
                        ],
                      ),
                    ),
                  ).toList() ?? [],
                  validator: FormBuilderValidators.required(),
                  isLoading: isLoading,
                  onChanged: (value){
                    if(value != null){
                      selectedVehicleType = value;
                      setState(() {});
                    }
                  }
                ),
                dropdownWithTitle<VehicleBrands>(
                    context,
                    title: localize(context).vehicle_brands,
                    hintText: localize(context).select_vehicle_brand,
                    items: gerDropDownData()?.vehicleBrands?.map(
                          (e) => DropdownMenuItem<VehicleBrands>(
                        value: e,
                        child:Text(
                          e.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyMedium?.copyWith(fontSize: 15.sp),
                        )
                      ),
                    ).toList() ?? [],
                    validator: FormBuilderValidators.required(),
                    isLoading: isLoading,
                    onChanged: (value){
                      if(value != null){
                        selectedVehicleBrand = value;
                        setState(() {});
                      }
                    }
                ),

                textFieldFromBuilderWithTitle(
                  context,
                  title: localize(context).vehicle_model,
                  name: 'vehicleModel',
                  hintText: localize(context).vehicle_model_name,
                  controller: vehicleModelController,
                ),
                dropdownWithTitle<VehicleColors>(
                    context,
                    title: localize(context).vehicle_color,
                    hintText: localize(context).select_vehicle_color,
                    items: gerDropDownData()?.colors?.map(
                          (e) => DropdownMenuItem<VehicleColors>(
                          value: e,
                          child:Text(
                            e.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyMedium?.copyWith(fontSize: 15.sp),
                          )
                      ),
                    ).toList() ?? [],
                    validator: FormBuilderValidators.required(),
                    isLoading: isLoading,
                    onChanged: (value){
                      if(value != null){
                        selectedVehicleColor = value;
                        setState(() {});
                      }
                    }
                ),
      
                dropdownWithTitle<FuelTypes>(
                    context,
                    title: localize(context).fuel_types,
                    hintText: localize(context).select_fuel_types,
                    items: gerDropDownData()?.fuelTypes?.map(
                          (e) => DropdownMenuItem<FuelTypes>(
                          value: e,
                          child:Text(
                            e.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyMedium?.copyWith(fontSize: 15.sp),
                          )
                      ),
                    ).toList() ?? [],
                    validator: FormBuilderValidators.required(),
                    isLoading: isLoading,
                    onChanged: (value){
                      if(value != null){
                        selectedFuelType = value;
                        setState(() {});
                      }
                    }
                ),
                dropdownWithTitle<GearTypes>(
                    context,
                    title: localize(context).gear_types,
                    hintText: localize(context).select_gear_types,
                    items: gerDropDownData()?.gearTypes?.map(
                          (e) => DropdownMenuItem<GearTypes>(
                          value: e,
                          child:Text(
                            e.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyMedium?.copyWith(fontSize: 15.sp),
                          )
                      ),
                    ).toList() ?? [],
                    validator: FormBuilderValidators.required(),
                    isLoading: isLoading,
                    onChanged: (value){
                      if(value != null){
                        selectedGearType = value;
                        setState(() {});
                      }
                    }
                ),
                textFieldFromBuilderWithTitle(
                  context,
                  title: localize(context).plate_number,
                  name: 'licensePlateNumber',
                  hintText: localize(context).vehicle_plate_number,
                  controller: plateNumberController,
                ),
      
                DynamicYearDropdownFormField(
                  startDate: DateTime(1990),
                  endDate: DateTime.now(),
                  controller: manufactureYearController,
                  hintText: localize(context).vehicle_production_year,
                  title: localize(context).production_year,
                ),
      
                /// --- Image Picker Fields ---
                imagePickerFormField(
                  context: context,
                  name: 'inspectionCertificate',
                  // title: localize(context).nid_photo,
                  title: localize(context).inspection_certificate,
                  initialFile: inspectionCertificate,
                  validator: (file) =>
                      file == null ? localize(context).inspection_certificate_required : null,
                  onChanged: (file) => setState(() => inspectionCertificate = file),
                ),
                Gap(16.h),
                imagePickerFormField(
                  context: context,
                  name: 'registrationCertificate',
                  title: localize(context).registration_certificate,
                  initialFile: registrationCertificate,
                  validator: (file) => file == null
                      ? localize(context).registration_certificate_required
                      : null,
                  onChanged: (file) => setState(() => registrationCertificate = file),
                ),
                Gap(16.h),
                imagePickerFormField(
                  context: context,
                  name: 'insurancePolicy',
                  title: localize(context).insurance_policy,
                  initialFile: insuranceCertificate,
                  validator: (file) => file == null
                      ? localize(context).insurance_policy_required
                      : null,
                  onChanged: (file) => setState(() => insuranceCertificate = file),
                ),
                Gap(16.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Consumer(
          builder: (context, ref, _) => AuthBottomButtons(
            title: localize(context).next,
            onTap: () async {
              if (formKey.currentState!.saveAndValidate()) {
                // final formData = Map<String, dynamic>.from(formKey.currentState!.value);
                final formData = {
                  'vehicleModel': vehicleModelController.text.trim(),
                  'categoryId': selectedVehicleType?.id,
                  'vehicleBrand': selectedVehicleBrand?.name,
                  'vehicleColor': selectedVehicleColor?.name,
                  'fuelType': selectedFuelType?.name,
                  'gearType': selectedGearType?.name,
                  'licensePlateNumber': plateNumberController.text,
                  'yearOfManufacture': manufactureYearController.text,
                  'inspectionCertificate': inspectionCertificate,
                  'registrationCertificate': registrationCertificate,
                  'insurancePolicy': insuranceCertificate,

                };
                log(formData.toString());
                ref.read(driverInfoProvider.notifier).updateVehicleInfo(formData);
                NavigationService.pushNamed(AppRoutes.bankInfoPage);
              } else {
                showNotification(message: localize(context).all_field_required);
              }
            },
          ),
        ),
      ),
    );
  }
}
