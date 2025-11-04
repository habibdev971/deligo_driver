import 'package:deligo_driver/core/utils/device_token_firebase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_state.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/auth_models/registration_model.dart';
import '../../../data/repositories/interfaces/auth_repo_interface.dart';
import '../../../data/services/local_storage_service.dart';
import '../../../data/services/navigation_service.dart';

class LoginWithPhoneOrEmailNotifier extends StateNotifier<AppState<RegistrationModel>> {
  final IAuthRepo authRepo;
  final Ref ref;

  LoginWithPhoneOrEmailNotifier({required this.ref, required this.authRepo})
      : super(const AppState.initial());

  Future<void> loginWithPhoneOrEmail({
    required String mobile,
    required String password,
  }) async {
    state = const AppState.loading();
    final String? deviceToken = await deviceTokenFirebase();
    await LocalStorageService().clearToken();
    // log('---------------->>> mobile: $mobile, password: $password');
    final result = await authRepo.loginPhoneOrEmail(
      phoneOrEmail: mobile,
      password: password,
      deviceToken: deviceToken,
    );
    result.fold(
          (failure) {
        showNotification(message: failure.message);
        return state = AppState.error(failure);
      },
          (data) {
        showNotification(message: data.message, isSuccess: true);
        LocalStorageService().saveToken(data.data!.token!);
        LocalStorageService().saveUser(data: data.data!.user!.toJson());
        LocalStorageService().setRegistrationProgress(AppRoutes.dashboard);
        state = AppState.success(data);

        NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}