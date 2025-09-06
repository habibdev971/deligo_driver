import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:deligo_driver/data/models/common_response.dart';
import 'package:deligo_driver/data/models/documents_upload_response/documents_upload_response.dart';
import 'package:deligo_driver/data/models/driver_details_response/driver_details_response.dart';
import 'package:deligo_driver/data/models/driver_info_update_response/driver_info_update_response.dart';
import 'package:deligo_driver/data/models/login_response/login_response.dart';
import 'package:deligo_driver/data/models/otp_verify_response/otp_verify_response.dart';

import '../../../core/errors/failure.dart';
import '../../models/forgot_verify_otp_response/forgot_verify_otp_response.dart';
import '../../models/login_with_pass_response/login_with_pass_response.dart';
import '../../models/resend_otp_model/resend_otp_mode.dart';

abstract class IAuthRepository {
  Future<Either<Failure, LoginResponse>> login({required String mobile, required String countryCode, String? deviceToken});
  Future<Either<Failure, LoginWithPassResponse>> resendSignIn({required num? userId, required String? deviceToken});
  Future<Either<Failure, LoginWithPassResponse>> loginWithPassword({required String mobile, required String password, String? deviceToken});
  Future<Either<Failure, OtpVerifyResponse>> verifyOtp({required String mobile, required String otp, String? deviceToken});
  Future<Either<Failure, CommonResponse>> updatePassword({required String password});
  Future<Either<Failure, CommonResponse>> changePassword({required String currentPassword, required String newPassword, required newConfirmPassword});
  Future<Either<Failure, ResendOtpModel>> resendOTP({required String mobile});
  Future<Either<Failure, CommonResponse>> requestOTP({required String mobile});
  Future<Either<Failure, ForgotVerifyOtpResponse>> forgetVerifyOtp({required String mobile, required String otp});
  Future<Either<Failure, CommonResponse>> resetPassword({required Map<String, dynamic> data});
  Future<Either<Failure, DriverInfoUpdateResponse>> updatePersonalInfo({required File profilePicture, required Map<String, dynamic> data});
  Future<Either<Failure, DriverInfoUpdateResponse>> updateProfile({required Map<String, dynamic> data});
  Future<Either<Failure, CommonResponse>> updateVehicleDetails({required List<File> documents, required Map<String, dynamic> data});
  Future<Either<Failure, DriverDetailsResponse>> getDriverDetails();
  Future<Either<Failure, CommonResponse>> updateProfilePhoto({required String imagePath});
  Future<Either<Failure, DocumentsUploadResponse>> uploadDocuments(
      {required File profilePicture, required List<File> documents});
  Future<Either<Failure, CommonResponse>> logout();
}
