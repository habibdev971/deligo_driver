import 'dart:io';

import 'package:deligo_driver/data/models/auth_models/driver_dropdown_model_data/driver_dropdown_model.dart';
import 'package:deligo_driver/data/models/auth_models/initial_registration_model.dart';
import 'package:deligo_driver/data/models/user_existence_model/user_existence_model.dart';
import 'package:deligo_driver/presentation/auth/view_model/driver_dropdown_notifier.dart';
import 'package:deligo_driver/presentation/auth/view_model/login_with_phone_email_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/core/config/environment.dart';
import 'package:deligo_driver/data/models/documents_upload_response/documents_upload_response.dart';
import 'package:deligo_driver/data/models/driver_info_update_response/driver_info_update_response.dart';
import 'package:deligo_driver/data/repositories/interfaces/auth_repo_interface.dart';
import 'package:deligo_driver/data/services/auth_service.dart';
import 'package:deligo_driver/domain/interfaces/auth_service_interface.dart';
import 'package:deligo_driver/presentation/auth/view_model/auth_notifier.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/auth_models/registration_model.dart';
import '../../../data/models/common_response.dart';
import '../../../data/models/login_with_pass_response/login_with_pass_response.dart';
import '../../../data/models/otp_verify_response/otp_verify_response.dart';
import '../../../data/models/resend_otp_model/resend_otp_mode.dart';
import '../../../data/repositories/auth_repo_impl.dart';
import '../../../data/services/api/dio_client.dart';
import '../view_model/registration_notifier.dart';

// DioClient provider to provide DioClient instance
final dioClientProvider = Provider<DioClient>((ref) => DioClient());
final dioClientChattingProvider = Provider<DioClient>((ref) => DioClient(baseUrl: '${Environment.baseUrl}/api'));

// Service Provider
final authServiceProvider = Provider<IAuthService>((ref) => AuthServiceImpl(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final authRepoProvider = Provider<IAuthRepo>((ref) => AuthRepoImpl(authService: ref.read(authServiceProvider)));

// Notifier Providers
final existingUserProvider = StateNotifierProvider<ExistingUserNotifier, AppState<UserExistenceModel>>(
    (ref) => ExistingUserNotifier(authRepoProvider: ref.read(authRepoProvider), ref: ref));

final initialRegistrationProvider = StateNotifierProvider<InitialRegistrationNotifier, AppState<InitialRegistrationModel>>(
        (ref) => InitialRegistrationNotifier(authRepo: ref.read(authRepoProvider), ref: ref));

final registrationProvider = StateNotifierProvider<RegistrationNotifier, AppState<RegistrationModel>>(
        (ref) => RegistrationNotifier(authRepo: ref.read(authRepoProvider), ref: ref));

final loginWithPhoneOrEmailProvider = StateNotifierProvider<LoginWithPhoneOrEmailNotifier, AppState<RegistrationModel>>(
        (ref) => LoginWithPhoneOrEmailNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final loginWithPassNotifierProvider = StateNotifierProvider<LoginWithPassNotifier, AppState<LoginWithPassResponse>>(
    (ref) => LoginWithPassNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final resendSignInProvider = StateNotifierProvider<ResendSignInNotifier, AppState<LoginWithPassResponse>>(
        (ref) => ResendSignInNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final otpVerifyNotifierProvider = StateNotifierProvider<OtpVerifyNotifier, AppState<OtpVerifyResponse>>(
    (ref) => OtpVerifyNotifier(authRepoProvider: ref.read(authRepoProvider), ref: ref));

final updatePassViewModelProvider = StateNotifierProvider.autoDispose<UpdatePassViewModel, AppState<CommonResponse>>(
    (ref) => UpdatePassViewModel(authRepo: ref.read(authRepoProvider), ref: ref));

final resendOTPNotifierProvider = StateNotifierProvider.autoDispose<ResendOtpNotifier, AppState<ResendOtpModel>>(
    (ref) => ResendOtpNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final resetPasswordNotifierProvider = StateNotifierProvider.autoDispose<ResetPasswordNotifier, AppState<CommonResponse>>(
    (ref) => ResetPasswordNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final changePasswordProvider = StateNotifierProvider.autoDispose<ChangePasswordNotifier, AppState<CommonResponse>>(
        (ref) => ChangePasswordNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final updatePersonalInfoProvider =
    StateNotifierProvider.autoDispose<UpdatePersonalInfoNotifier, AppState<DriverInfoUpdateResponse>>(
        (ref) => UpdatePersonalInfoNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final updateVehicleDetailsNotifierProvider =
    StateNotifierProvider<UpdateVehicleDetailsNotifier, AppState<CommonResponse>>(
        (ref) => UpdateVehicleDetailsNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final logoutNotifierProvider = StateNotifierProvider<LogoutNotifier, AppState<CommonResponse>>(
    (ref) => LogoutNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final uploadDocumentsNotifierProvider =
    StateNotifierProvider.autoDispose<DocumentUploadNotifier, AppState<DocumentsUploadResponse>>(
        (ref) => DocumentUploadNotifier(authRepo: ref.read(authRepoProvider)));

final requiredDocsNotifierProvider =
    StateNotifierProvider.autoDispose<RequiredDocsNotifier, List<File>>((ref) => RequiredDocsNotifier());

final driverDropdownProvider = StateNotifierProvider<DriverDropdownNotifier, AppState<DriverDropdownModel>>(
        (ref) => DriverDropdownNotifier(repo: ref.read(authRepoProvider), ref: ref));
