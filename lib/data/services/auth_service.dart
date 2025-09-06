import 'dart:io';

import 'package:dio/dio.dart';
import 'package:deligo_driver/core/config/api_endpoints.dart';
import 'package:deligo_driver/data/services/api/dio_client.dart';
import 'package:deligo_driver/domain/interfaces/auth_service_interface.dart';

import 'local_storage_service.dart';

class AuthServiceImpl extends IAuthService {
  final DioClient dioClient;

  AuthServiceImpl({required this.dioClient});
  @override
  Future<Response> forgetVerifyOtp({required String mobile, required String otp}) async => await dioClient.dio.post(ApiEndpoints.forgetVerifyOtp, data: {
      'mobile': mobile,
      'otp': otp,
    });

  @override
  Future<Response> login({required String phone, required String countryCode, String? deviceToken}) async => await dioClient.dio.post(
      ApiEndpoints.loginUrl,
      data: {'mobile': phone, 'device_token': deviceToken, 'country_code': countryCode},
    );

  @override
  Future<Response> resendSignIn({required num? userId, required String? deviceToken}) async => await dioClient.dio.post(
    '${ApiEndpoints.resendSignIn}/$userId',
    data: {
      'device_token': deviceToken,
    }
  );

  @override
  Future<Response> loginWithPassword({required String mobile, required String password, String? deviceToken}) async => await dioClient.dio.post(
      ApiEndpoints.loginUrl,
      data: {
        'mobile': mobile,
        'country_code': await LocalStorageService().getCountryCode(),
        'password': password,
        'device_token': deviceToken
      },
    );
  @override
  Future<Response> changePassword({required String currentPassword, required String newPassword, required newConfirmPassword}) async => await dioClient.dio.post(
      ApiEndpoints.changePassword,
      data: {
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': newConfirmPassword
      },
    );


  @override
  Future<Response> logout() async => await dioClient.dio.get(ApiEndpoints.logout);

  @override
  Future<Response> requestOTP({required String mobile}) async => await dioClient.dio.post(ApiEndpoints.requestOTP, data: {
      'mobile': mobile,
    });

  @override
  Future<Response> resendOTP({required String mobile}) async => await dioClient.dio.post(
      ApiEndpoints.resendOTP,
      data: {'mobile': mobile},
    );

  @override
  Future<Response> resetPassword({required Map<String, dynamic> data}) async => await dioClient.dio.post(ApiEndpoints.resetPassword, data: data);

  @override
  Future<Response> updatePassword({required String password}) async => dioClient.dio.post(ApiEndpoints.updatePassword, data: {
      'password': password,
      'password_confirmation': password,
    });

  @override
  Future<Response> updateProfilePhoto({required String imagePath}) async {
    final FormData formData = FormData.fromMap({
      'profile_picture': await MultipartFile.fromFile(imagePath),
    });
    return await dioClient.dio.post(ApiEndpoints.updateProfilePhoto, data: formData);
  }

  @override
  Future<Response> verifyOtp({required String mobile, required String otp, String? deviceToken}) async => await dioClient.dio.post(
      ApiEndpoints.loginUrl,
      data: {
        'mobile': mobile,
        'country_code': await LocalStorageService().getCountryCode(),
        'otp': otp,
        'device_token': deviceToken
      },
    );

  @override
  Future<Response> updatePersonalInfo({required File profilePicture, required Map<String, dynamic> data}) async {
    final FormData formData = FormData();

    formData.files.add(
      MapEntry(
        'profile_picture',
        await MultipartFile.fromFile(
          profilePicture.path,
          filename: profilePicture.path.split('/').last,
        ),
      ),
    );

    data.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });
    return await dioClient.dio.post(
      ApiEndpoints.updatePersonalInfo,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
        },
      ),
    );
  }

  @override
  Future<Response> updateProfile({required Map<String, dynamic> data}) async => await dioClient.dio.post(
      ApiEndpoints.updateProfile,
      data: data,
    );


  @override
  Future<Response> updateVehicleDetails({
    required List<File> documents,
    required Map<String, dynamic> data,
  }) async {
    final FormData formData = FormData();

    if (documents.length >= 3) {
      formData.files.addAll([
        MapEntry(
          'nid',
          await MultipartFile.fromFile(
            documents[0].path,
            filename: documents[0].path.split('/').last,
          ),
        ),
        MapEntry(
          'license',
          await MultipartFile.fromFile(
            documents[1].path,
            filename: documents[1].path.split('/').last,
          ),
        ),
        MapEntry(
          'vehicle_paper',
          await MultipartFile.fromFile(
            documents[2].path,
            filename: documents[2].path.split('/').last,
          ),
        ),
      ]);
    } else {
      throw Exception('Documents list must contain at least 3 files: nid, license, vehicle_paper');
    }

    data.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    return await dioClient.dio.post(
      ApiEndpoints.updateVehicleDetails,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
        },
      ),
    );
  }


  @override
  Future<Response> uploadDocuments({required File profilePicture, required List<File> documents}) async {
    // Convert files to MultipartFile
    final FormData formData = FormData();

    formData.files.addAll([
      MapEntry(
        'profile_picture',
        await MultipartFile.fromFile(profilePicture.path, filename: profilePicture.path.split('/').last),
      )
    ]);

    for (var doc in documents) {
      formData.files.add(
        MapEntry(
          'documents[]', // Ensure correct key for multiple files
          await MultipartFile.fromFile(doc.path, filename: doc.path.split('/').last),
        ),
      );
    }

    return await dioClient.dio.post(
      ApiEndpoints.uploadDocuments,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
        },
      ),
    );
  }

  @override
  Future<Response> getDriverDetails() async => await dioClient.dio.get(ApiEndpoints.getDriverDetails);
}
