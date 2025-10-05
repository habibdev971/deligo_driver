import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_state.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/auth_models/registration_model.dart';
import '../../../data/repositories/interfaces/auth_repo_interface.dart';
import '../../../data/services/local_storage_service.dart';
import '../../../data/services/navigation_service.dart';

class RegistrationNotifier extends StateNotifier<AppState<RegistrationModel>> {
  final IAuthRepo authRepo;
  final Ref ref;

  RegistrationNotifier({required this.ref, required this.authRepo})
      : super(const AppState.initial());

  Future<void> registration({
    required String mobile,
    required String email,
    required String firstName,
    required String lastName,
    required String gender,
    Function? onSuccess,
    // String? password,
  }) async {
    state = const AppState.loading();
    final String? deviceToken = await FirebaseMessaging.instance.getToken();
    await LocalStorageService().clearToken();
    final result = await authRepo.registration(
      data: {
        'mobile': mobile,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'gender': gender,
        'device_token': deviceToken,

      }
    );
    result.fold(
          (failure) {
        showNotification(message: failure.message);
        return state = AppState.error(failure);
      },
          (data) async {
        if(onSuccess != null){
          onSuccess();
        }
        showNotification(
          message: data.message,
          isSuccess: true,
          type: MessageType.snackBar,
        );
        LocalStorageService().setRegistrationProgress(AppRoutes.driverPersonalInfoPage);
        state = AppState.success(data);
        await LocalStorageService().saveToken(data.data!.token);
        NavigationService.pushNamed(AppRoutes.setPassword, arguments: mobile);
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}
