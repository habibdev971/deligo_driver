import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:deligo_driver/data/models/common_response.dart';
import 'package:deligo_driver/data/models/documents_upload_response/documents_upload_response.dart';
import 'package:deligo_driver/data/models/driver_details_response/driver_details_response.dart';
import 'package:deligo_driver/data/models/driver_info_update_response/driver_info_update_response.dart';
import 'package:deligo_driver/data/models/forgot_verify_otp_response/forgot_verify_otp_response.dart';
import 'package:deligo_driver/data/models/otp_verify_response/otp_verify_response.dart';
import 'package:deligo_driver/data/models/resend_otp_model/resend_otp_mode.dart';
import 'package:deligo_driver/data/models/user_existence_model/user_existence_model.dart';
import 'package:deligo_driver/data/repositories/base_repository.dart';
import 'package:deligo_driver/domain/interfaces/auth_service_interface.dart';

import '../../core/errors/failure.dart';
import '../models/auth_models/driver_dropdown_model_data/driver_dropdown_model.dart';
import '../models/auth_models/registration_model.dart';
import '../models/login_with_pass_response/login_with_pass_response.dart';
import 'interfaces/auth_repo_interface.dart';

class AuthRepoImpl extends BaseRepository implements IAuthRepo {
  final IAuthService authService;

  AuthRepoImpl({required this.authService});

  @override
  Future<Either<Failure, DriverDropdownModel>> getDriverDropdownData() async => await safeApiCall(() async {
      final response = await authService.getDriverDropdownData();
      return DriverDropdownModel.fromJson(response.data);
  });

  @override
  Future<Either<Failure, UserExistenceModel>> checkUserExistence({required String mobile, String? deviceToken, required String countryCode, }) async => await safeApiCall(() async {
      final response = await authService.checkUserExistence(phone: mobile,  deviceToken: deviceToken, countryCode: countryCode);
      return UserExistenceModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, RegistrationModel>> registration({required Map<String, dynamic> data,})async => await safeApiCall(() async {
      final response = await authService.registration(data: data);
      return RegistrationModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, RegistrationModel>> loginPhoneOrEmail({required String phoneOrEmail, required String password, String? deviceToken}) async => await safeApiCall(() async {
      final response = await authService.loginPhoneOrEmail(phoneOrEmail: phoneOrEmail, password: password, deviceToken: deviceToken);
      return RegistrationModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, LoginWithPassResponse>> resendSignIn({required num? userId, required String? deviceToken}) async => await safeApiCall(() async {
    final response = await authService.resendSignIn(userId: userId, deviceToken: deviceToken);
    return LoginWithPassResponse.fromMap(response.data);
  });

  @override
  Future<Either<Failure, OtpVerifyResponse>> verifyOtp({required String mobile, required String otp, String? deviceToken}) async => await safeApiCall(() async {
      final response = await authService.verifyOtp(mobile: mobile, otp: otp, deviceToken: deviceToken);
      return OtpVerifyResponse.fromMap(response.data);
    });

  @override
  Future<Either<Failure, CommonResponse>> updatePassword({required String password}) async => await safeApiCall(() async {
      final response = await authService.updatePassword(password: password);
      return CommonResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, CommonResponse>> changePassword({required String currentPassword, required String newPassword, required newConfirmPassword}) async => await safeApiCall(() async {
      final response = await authService.changePassword(currentPassword: currentPassword, newPassword: newPassword, newConfirmPassword: newConfirmPassword);
      return CommonResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, ResendOtpModel>> resendOTP({required String mobile}) async => await safeApiCall(() async {
      final response = await authService.resendOTP(mobile: mobile);
      return ResendOtpModel.fromJson(response.data);
    });

  @override
  Future<Either<Failure, LoginWithPassResponse>> loginWithPassword({
    required String mobile,
    required String password,
   String? deviceToken,
  }) async => await safeApiCall(() async {
      final response = await authService.loginWithPassword(mobile: mobile, password: password, deviceToken: deviceToken);
      try{
        return LoginWithPassResponse.fromMap(response.data);
      }catch(e){
        return LoginWithPassResponse.fromMap(response.data);
      }
    });

  @override
  Future<Either<Failure, CommonResponse>> requestOTP({required String mobile}) async => await safeApiCall(() async {
      final response = await authService.requestOTP(mobile: mobile);
      return CommonResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, ForgotVerifyOtpResponse>> forgetVerifyOtp({required String mobile, required String otp}) async => await safeApiCall(() async {
      final response = await authService.forgetVerifyOtp(mobile: mobile, otp: otp);
      return ForgotVerifyOtpResponse.fromMap(response.data);
    });

  @override
  Future<Either<Failure, CommonResponse>> resetPassword({required Map<String, dynamic> data}) async => await safeApiCall(() async {
      final response = await authService.resetPassword(data: data);
      return CommonResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, DriverInfoUpdateResponse>> updatePersonalInfo({required File profilePicture, required Map<String, dynamic> data}) async => await safeApiCall(() async {
      final response = await authService.updatePersonalInfo(data: data, profilePicture: profilePicture);
      return DriverInfoUpdateResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, DriverInfoUpdateResponse>> updateProfile({required Map<String, dynamic> data}) async => await safeApiCall(() async {
      final response = await authService.updateProfile(data: data);
      return DriverInfoUpdateResponse.fromJson(response.data);
    });


  @override
  Future<Either<Failure, CommonResponse>> updateVehicleDetails({required List<File> documents, required Map<String, dynamic> data}) async => await safeApiCall(() async {
      final response = await authService.updateVehicleDetails(data: data, documents: documents);
      return CommonResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, CommonResponse>> logout() async => await safeApiCall(() async {
      final response = await authService.logout();
      return CommonResponse.fromJson(response.data);
    });

  @override
  Future<Either<Failure, DocumentsUploadResponse>> uploadDocuments(
      {required File profilePicture, required List<File> documents}) async => await safeApiCall(() async {
      final response = await authService.uploadDocuments(profilePicture: profilePicture, documents: documents);
      return DocumentsUploadResponse.fromMap(response.data);
    });

  @override
  Future<Either<Failure, DriverDetailsResponse>> getDriverDetails() async => await safeApiCall(() async {
      final response = await authService.getDriverDetails();
      try{
        return DriverDetailsResponse.fromJson(response.data);
      }catch(e){
        return DriverDetailsResponse.fromJson(response.data);
      }
    });

  @override
  Future<Either<Failure, CommonResponse>> updateProfilePhoto({required String imagePath}) async => await safeApiCall(() async {
      final response = await authService.updateProfilePhoto(imagePath: imagePath);
      return CommonResponse.fromJson(response.data);
    });
}
