import 'package:deligo_driver/data/models/auth_models/initial_registration_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_state.dart';
import '../../../core/utils/helpers.dart';
import '../../../data/models/auth_models/registration_model.dart';
import '../../../data/repositories/interfaces/auth_repo_interface.dart';
import '../../../data/services/local_storage_service.dart';
import '../../../data/services/navigation_service.dart';
import '../provider/driver_info_provider.dart';

class InitialRegistrationNotifier extends StateNotifier<AppState<InitialRegistrationModel>> {
  final IAuthRepo authRepo;
  final Ref ref;

  InitialRegistrationNotifier({required this.ref, required this.authRepo})
      : super(const AppState.initial());

  Future<void> initialRegistration({required Map<String, dynamic> data}) async {
    state = const AppState.loading();
    // final String? deviceToken = await FirebaseMessaging.instance.getToken();
    await LocalStorageService().clearToken();
    // final Map<String, dynamic> allData = {}
    // ..addAll(ref.read(driverInfoProvider).personalInfo);

    // allData = ;
    final result = await authRepo.initialRegistration(
      data: data
    );
    result.fold(
          (failure) {
        showNotification(message: failure.message);
        return state = AppState.error(failure);
      },
          (data) async {

        showNotification(
          message: data.message,
          isSuccess: true,
          type: MessageType.snackBar,
        );
        LocalStorageService().setRegistrationProgress(AppRoutes.driverPersonalInfoPage);
        state = AppState.success(data);
        // await LocalStorageService().saveToken(data.data!.token);
        NavigationService.pushNamed(AppRoutes.verifyOTP, arguments: ref.read(driverInfoProvider).personalInfo['phoneNumber']);
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}
class RegistrationNotifier extends StateNotifier<AppState<RegistrationModel>> {
  final IAuthRepo authRepo;
  final Ref ref;

  RegistrationNotifier({required this.ref, required this.authRepo})
      : super(const AppState.initial());

  Future<void> registration() async {
    state = const AppState.loading();
    final String? deviceToken = await FirebaseMessaging.instance.getToken();
    await LocalStorageService().clearToken();
    final Map<String, dynamic> allData = {}
    ..addAll(ref.read(driverInfoProvider).personalInfo)
      ..addAll(ref.read(driverInfoProvider).legalDocuments)
      ..addAll(ref.read(driverInfoProvider).vehicleInfo)
      ..addAll(ref.read(driverInfoProvider).bankPaymentInfo)
      ..addAll(ref.read(driverInfoProvider).agreement);


    final result = await authRepo.registration(
      data: allData
    );
    result.fold(
          (failure) {
        showNotification(message: failure.message);
        return state = AppState.error(failure);
      },
          (data) async {

        showNotification(
          message: data.message,
          isSuccess: true,
          type: MessageType.snackBar,
        );
        LocalStorageService().setRegistrationProgress(AppRoutes.driverPersonalInfoPage);
        state = AppState.success(data);
        // await LocalStorageService().saveToken(data.data!.token);
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.login,);
      },
    );
  }

  void resetStateAfterDelay() {
    Future.delayed(Duration.zero, () {
      state = const AppState.initial();
    });
  }
}
