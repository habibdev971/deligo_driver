import 'dart:io';
import 'package:deligo_driver/data/models/user_existence_model/user_existence_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/core/state/app_state.dart';
import 'package:deligo_driver/core/utils/device_token_firebase.dart';
import 'package:deligo_driver/data/models/documents_upload_response/documents_upload_response.dart';
import 'package:deligo_driver/data/models/driver_info_update_response/driver_info_update_response.dart';
import 'package:deligo_driver/data/repositories/interfaces/auth_repo_interface.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/presentation/auth/widgets/warning.dart';
import 'package:deligo_driver/presentation/booking/provider/ride_providers.dart';
import 'package:deligo_driver/presentation/profile/provider/profile_providers.dart';
import 'package:deligo_driver/presentation/splash/provider/app_flow_providers.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/auth_models/otp_verify_model/OtpVerifyModel.dart';
import '../../../data/models/common_response.dart';
import '../../../data/models/login_with_pass_response/login_with_pass_response.dart';
import '../../../data/models/resend_otp_model/resend_otp_mode.dart';
import '../../../data/services/firebase_auth_service.dart';

class ExistingUserNotifier extends StateNotifier<AppState<UserExistenceModel>> {
  final IAuthRepo authRepoProvider;
  final Ref ref;
  ExistingUserNotifier({required this.authRepoProvider, required this.ref})
    : super(const AppState.initial());

  Future<void> checkExistenceUser({
    required String phone,
    required String countryCode,
  }) async {
    state = const AppState.loading();
    final String? deviceToken = await deviceTokenFirebase();
    await LocalStorageService().clearToken();
    final response = await authRepoProvider.checkUserExistence(
      mobile: phone,
      deviceToken: deviceToken,
      countryCode: countryCode,
    );
    response.fold(
      (failure) {
        showNotification(message: failure.message);
        return state = AppState.error(failure);
      },
      (data) {
        _handleLoginSuccess(data.data, phone);
        return state = AppState.success(data);
      },
    );
  }

  void _handleLoginSuccess(ExistenceData? data, String phone) {
    // final localStorage = LocalStorageService();
    final isNewUser = data?.isNew == true;
    // final isUnderReview = loginResponse.data?.isUnderReview == true;
    final isUnderReview = data?.isLicenseVerified == false;
    if (isNewUser ) { //|| (isNewUser == false && data?.isDriver == false)
      // showNotification(message: 'otp: ${loginResponse.data?.otp}', isSuccess: true);
      final loading = ref.read(authLoadingProvider.notifier);

      firebaseAuthNotifier.value.signInWithMobile(phone,
          onLoadingChange: (val) => loading.state = val,
      );
        // ..setRegistrationProgress(AppRoutes.verifyOtp);
      // NavigationService.pushNamed(
      //   AppRoutes.verifyOtp,
      //   // arguments: (loginResponse.data?.otp ?? '').toString(),
      // );
    } else {
      if (isUnderReview && data?.isDriver == false) {
        NavigationService.pushNamed(AppRoutes.driverPersonalInfoPage, arguments: phone);
      }else if(isUnderReview){
        NavigationService.pushNamed(AppRoutes.profileUnderReview);
      } else {
        NavigationService.pushNamed(AppRoutes.loginWithPassword);
      }
    }
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class LoginWithPassNotifier
    extends StateNotifier<AppState<LoginWithPassResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;

  LoginWithPassNotifier({required this.ref, required this.authRepo})
    : super(const AppState.initial());

  Future<void> loginWithPassword({
    required String mobile,
    required String password,
  }) async {
    state = const AppState.loading();
    final String? deviceToken = await deviceTokenFirebase();
    await LocalStorageService().clearToken();
    final result = await authRepo.loginWithPassword(
      mobile: mobile,
      password: password,
      deviceToken: deviceToken,
    );
    result.fold(
      (failure) {
        showNotification(message: failure.message);
        return state = AppState.error(failure);
      },
      (data) async {
        showNotification(
          message: data.message,
          isSuccess: !(data.data?.otherDevice ?? false),
        );
        if (data.data?.otherDevice != null && data.data?.otherDevice == true) {
          showWarning(
            ref: ref,
            userId: data.data?.user?.id,
            deviceToken: deviceToken,
          );
          state = AppState.success(data);
          return;
        }
        LocalStorageService().saveToken(data.data?.token);
        LocalStorageService().saveUser(data: data.data?.user?.toJson());
        LocalStorageService().setRegistrationProgress(AppRoutes.dashboard);

        await ref
            .read(tripActivityNotifierProvider.notifier)
            .checkTripActivity();
        state = AppState.success(data);
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class ResendSignInNotifier
    extends StateNotifier<AppState<LoginWithPassResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;

  ResendSignInNotifier({required this.ref, required this.authRepo})
    : super(const AppState.initial());

  Future<void> resendSignIn({
    required num? userId,
    required String? deviceToken,
  }) async {
    state = const AppState.loading();
    final String? deviceToken = await deviceTokenFirebase();
    await LocalStorageService().clearToken();
    final result = await authRepo.resendSignIn(
      userId: userId,
      deviceToken: deviceToken,
    );
    result.fold(
      (failure) {
        showNotification(message: failure.message);
        return state = AppState.error(failure);
      },
      (data) {
        showNotification(message: data.message, isSuccess: true);

        LocalStorageService().saveToken(data.data?.token);
        LocalStorageService().saveUser(data: data.data?.user?.toJson());
        LocalStorageService().setRegistrationProgress(AppRoutes.dashboard);
        state = AppState.success(data);
        // NavigationService.pushNamedAndRemoveUntil(AppRoutes.splash);
        ref
            .read(tripActivityNotifierProvider.notifier)
            .checkTripActivity(
              onSuccess: () {
                ref.read(appFlowViewModelProvider.notifier).setAppFlowState();
              },
            );
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class OtpVerifyNotifier extends StateNotifier<AppState<OtpVerifyModel>> {
  final IAuthRepo authRepoProvider;
  final Ref ref;

  OtpVerifyNotifier({required this.authRepoProvider, required this.ref})
    : super(const AppState.initial());

  /// Main method to verify OTP
  Future<void> verifyOTP({required String mobile, required String otp}) async {
    state = const AppState.loading();
    final deviceToken = await FirebaseMessaging.instance.getToken();

    final result = await authRepoProvider.verifyOtp(
      mobile: mobile,
      otp: otp,
      deviceToken: deviceToken,
    );

    result.fold(
          (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
          (response) async{
        showNotification(message: response.message, isSuccess: true);
        state = AppState.success(response);
        await LocalStorageService().clearToken();
        await LocalStorageService().clearRegisterToken();
        await LocalStorageService().saveRegisterToken(response.data?.token);
        NavigationService.pushNamed(AppRoutes.driverPersonalInfoPage,);
      },
    );
  }
  // Future<void> verifyOTP({
  //   required String mobile,
  //   required String otp,
  // }) async {
  //   state = const AppState.loading();
  //
  //   final deviceToken = await deviceTokenFirebase();
  //   final loginData = _getLoginData();
  //
  //   final result = await authRepoProvider.verifyOtp(
  //     mobile: mobile,
  //     otp: otp,
  //     deviceToken: deviceToken,
  //   );
  //
  //   result.fold(
  //         (failure) => _handleFailure(failure),
  //         (response) => _handleSuccess(response, loginData, deviceToken: deviceToken),
  //   );
  // }
  //
  // /// Handle success response
  // void _handleSuccess(OtpVerifyResponse response, LoginResponse? loginData, {String? deviceToken}) {
  //   final token = response.data?.token;
  //   final user = response.data?.user?.toJson();
  //
  //   if (token != null) LocalStorageService().saveToken(token);
  //   if (user != null) LocalStorageService().saveUser(data: user);
  //
  //   // Navigate based on new driver flag
  //   final isNewDriver = loginData?.data?.isNewDriver ?? false;
  //
  //   if(response.data?.otherDevice == true){
  //     showWarning(ref: ref, userId: response.data?.user?.id, deviceToken: deviceToken);
  //   }else{
  //     if (isNewDriver) {
  //       _completeRegistration(AppRoutes.setPassword);
  //     } else {
  //
  //       _completeRegistration(AppRoutes.dashboard);
  //
  //     }
  //   }
  //
  //
  //   state = AppState.success(response);
  //   resetStateAfterDelay();
  // }
  //
  // /// Handle API failure
  // void _handleFailure(Failure failure) {
  //   showNotification(message: failure.message);
  //   state = AppState.error(failure);
  // }
  //
  // /// Get login response data if exists
  // LoginResponse? _getLoginData() => ref.read(existingUserProvider).maybeWhen(
  //     success: (data) => data,
  //     orElse: () => null,
  //   );
  //
  // /// Complete registration by saving progress and navigating
  // void _completeRegistration(String route) {
  //   LocalStorageService().setRegistrationProgress(route);
  //
  //   if (route == AppRoutes.dashboard) {
  //     ref.read(tripActivityNotifierProvider.notifier).checkTripActivity(onSuccess: (){
  //       ref.read(appFlowViewModelProvider.notifier).setAppFlowState();
  //     });
  //   } else {
  //     NavigationService.pushNamed(route);
  //   }
  // }
  //
  // /// Reset state after small delay (for UI)
  // void resetStateAfterDelay() {
  //   Future.delayed(Duration.zero, () {
  //     state = const AppState.initial();
  //   });
  // }
}

class UpdatePassViewModel extends StateNotifier<AppState<CommonResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  UpdatePassViewModel({required this.ref, required this.authRepo})
    : super(const AppState.initial());

  Future<void> updatePassword({required String password}) async {
    state = const AppState.loading();
    final result = await authRepo.updatePassword(password: password);
    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) async{
        showNotification(message: data.message, isSuccess: true);
        state = AppState.success(data);
        LocalStorageService().setRegistrationProgress(
          AppRoutes.driverPersonalInfoPage,
        );
        await LocalStorageService().clearToken();
        await LocalStorageService().clearRegisterToken();
        // await LocalStorageService().saveToken(data)
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.loginWithPassword);
        resetStateAfterDelay();
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class ResendOtpNotifier extends StateNotifier<AppState<ResendOtpModel>> {
  final IAuthRepo authRepo;
  final Ref ref;

  ResendOtpNotifier({required this.ref, required this.authRepo})
    : super(const AppState.initial());

  Future<void> resendOtp({
    required String mobile,
    Function(ResendOtpModel data)? onSuccess,
  }) async {
    state = const AppState.loading();
    final result = await authRepo.resendOTP(mobile: mobile);
    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) {
        showNotification(message: data.message, isSuccess: true);
        state = AppState.success(data);
        onSuccess != null ? onSuccess(data) : null;
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class ResetPasswordNotifier extends StateNotifier<AppState<CommonResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  ResetPasswordNotifier({required this.ref, required this.authRepo})
    : super(const AppState.initial());

  Future<void> resetPassword({required Map<String, dynamic> data}) async {
    state = const AppState.loading();
    final result = await authRepo.resetPassword(data: data);
    result.fold((failure) => state = AppState.error(failure), (data) {
      showNotification(message: data.message, isSuccess: true);
      NavigationService.pushNamed(AppRoutes.login);
      state = AppState.success(data);
      resetStateAfterDelay();
    });
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class ChangePasswordNotifier extends StateNotifier<AppState<CommonResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  ChangePasswordNotifier({required this.ref, required this.authRepo})
    : super(const AppState.initial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required newConfirmPassword,
  }) async {
    state = const AppState.loading();
    final result = await authRepo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      newConfirmPassword: newConfirmPassword,
    );
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) {
        LocalStorageService().clearToken();
        LocalStorageService().clearUser();
        showNotification(message: data.message, isSuccess: true);
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
        state = AppState.success(data);
        resetStateAfterDelay();
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class UpdatePersonalInfoNotifier
    extends StateNotifier<AppState<DriverInfoUpdateResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  UpdatePersonalInfoNotifier({required this.ref, required this.authRepo})
    : super(const AppState.initial());

  Future<void> updatePersonalInfo({
    required File profilePicture,
    required Map<String, dynamic> data,
  }) async {
    state = const AppState.loading();
    final result = await authRepo.updatePersonalInfo(
      data: data,
      profilePicture: profilePicture,
    );
    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) {
        state = AppState.success(data);
        showNotification(message: data.message, isSuccess: true);
        LocalStorageService().setRegistrationProgress(
          AppRoutes.vehicleInfoPage,
        );
        NavigationService.pushNamed(AppRoutes.vehicleInfoPage);
      },
    );
  }

  Future<void> updateProfile({required Map<String, dynamic> data}) async {
    state = const AppState.loading();
    final result = await authRepo.updateProfile(data: data);
    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) {
        state = AppState.success(data);
        showNotification(message: data.message, isSuccess: true);
        ref.read(driverDetailsNotifierProvider.notifier).getDriverDetails();
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class UpdateVehicleDetailsNotifier
    extends StateNotifier<AppState<CommonResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  UpdateVehicleDetailsNotifier({required this.ref, required this.authRepo})
    : super(const AppState.initial());

  Future<void> updateVehicleDetails({
    required List<File> documents,
    required Map<String, dynamic> data,
  }) async {
    state = const AppState.loading();
    final result = await authRepo.updateVehicleDetails(
      data: data,
      documents: documents,
    );
    result.fold(
      (failure) {
        showNotification(message: failure.message);
        state = AppState.error(failure);
      },
      (data) {
        showNotification(message: data.message, isSuccess: true);
        state = AppState.success(data);
        LocalStorageService().setRegistrationProgress(
          AppRoutes.profileUnderReview,
        );
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.profileUnderReview);
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class LogoutNotifier extends StateNotifier<AppState<CommonResponse>> {
  final IAuthRepo authRepo;
  final Ref ref;
  LogoutNotifier({required this.authRepo, required this.ref})
    : super(const AppState.initial());

  Future<void> logout() async {
    state = const AppState.loading();
    final result = await authRepo.logout();
    result.fold(
      (failure) {
        state = AppState.error(failure);
        showNotification(message: failure.message);
      },
      (data) {
        LocalStorageService().clearStorage();

        showNotification(message: data.message, isSuccess: true);
        state = AppState.success(data);
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
        resetStateAfterDelay();
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class DocumentUploadNotifier
    extends StateNotifier<AppState<DocumentsUploadResponse>> {
  final IAuthRepo authRepo;
  DocumentUploadNotifier({required this.authRepo})
    : super(const AppState.initial());

  Future<void> uploadDocuments({
    required File profilePicture,
    required List<File> documents,
  }) async {
    state = const AppState.loading();
    final result = await authRepo.uploadDocuments(
      profilePicture: profilePicture,
      documents: documents,
    );
    ();
    result.fold(
      (failure) {
        state = AppState.error(failure);
      },
      (data) {
        state = AppState.success(data);
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}

class RequiredDocsNotifier extends StateNotifier<List<File>> {
  RequiredDocsNotifier() : super([]);

  void addFile(File file) {
    state = [...state, file];
  }

  void removeFile(File file) {
    state = state.where((element) => element.path != file.path).toList();
  }

  void updateFile(int index, File file) {
    state[index] = file;
  }

  List<File> getFiles() => state;
}
