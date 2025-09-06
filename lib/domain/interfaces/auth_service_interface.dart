import 'dart:io';

import 'package:dio/dio.dart';

abstract class IAuthService {
  Future<Response> login({required String phone, required String countryCode, String? deviceToken});
  Future<Response> resendSignIn({required num? userId, required String? deviceToken});
  Future<Response> loginWithPassword({required String mobile, required String password, String? deviceToken});
  Future<Response> verifyOtp({required String mobile, required String otp, String? deviceToken});
  Future<Response> updatePassword({required String password});
  Future<Response> changePassword({required String currentPassword, required String newPassword, required newConfirmPassword});

  Future<Response> resendOTP({required String mobile});
  Future<Response> updateProfilePhoto({required String imagePath});
  Future<Response> requestOTP({required String mobile});
  Future<Response> forgetVerifyOtp(
      {required String mobile, required String otp});
  Future<Response> resetPassword({required Map<String, dynamic> data});
  Future<Response> updatePersonalInfo({required File profilePicture, required Map<String, dynamic> data});
  Future<Response> updateProfile({required Map<String, dynamic> data});
  Future<Response> updateVehicleDetails({required List<File> documents, required Map<String, dynamic> data});
  Future<Response> uploadDocuments(
      {required File profilePicture, required List<File> documents});
  Future<Response> getDriverDetails();
  Future<Response> logout();
}
