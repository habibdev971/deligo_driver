import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/core/config/environment.dart';
import 'package:deligo_driver/data/models/documents_upload_response/documents_upload_response.dart';
import 'package:deligo_driver/data/models/driver_info_update_response/driver_info_update_response.dart';
import 'package:deligo_driver/data/repositories/interfaces/auth_repo_interface.dart';
import 'package:deligo_driver/data/services/auth_service.dart';
import 'package:deligo_driver/domain/interfaces/auth_service_interface.dart';
import 'package:deligo_driver/presentation/auth/view_model/auth_notifier.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/common_response.dart';
import '../../../data/models/login_response/login_response.dart';
import '../../../data/models/login_with_pass_response/login_with_pass_response.dart';
import '../../../data/models/otp_verify_response/otp_verify_response.dart';
import '../../../data/models/resend_otp_model/resend_otp_mode.dart';
import '../../../data/repositories/auth_repo_impl.dart';
import '../../../data/services/api/dio_client.dart';

// DioClient provider to provide DioClient instance
final dioClientProvider = Provider<DioClient>((ref) => DioClient());
final dioClientChattingProvider = Provider<DioClient>((ref) => DioClient(baseUrl: '${Environment.baseUrl}/api'));

// Service Provider
final authServiceProvider = Provider<IAuthService>((ref) => AuthServiceImpl(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final authRepoProvider = Provider<IAuthRepository>((ref) => AuthRepoImpl(authService: ref.read(authServiceProvider)));

// Notifier Providers
final loginNotifierProvider = StateNotifierProvider<LoginNotifier, AppState<LoginResponse>>(
    (ref) => LoginNotifier(authRepoProvider: ref.read(authRepoProvider), ref: ref));

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
