import 'package:deligo_driver/core/state/app_state.dart';
import 'package:deligo_driver/data/models/auth_models/driver_dropdown_model_data/driver_dropdown_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/interfaces/auth_repo_interface.dart';

class DriverDropdownNotifier extends StateNotifier<AppState<DriverDropdownModel>>{
  final IAuthRepo repo;
  final Ref ref;
  DriverDropdownNotifier({required this.repo, required this.ref}) : super(const AppState.initial());

  Future<void> getDriverDropdownData() async {
    state = const AppState.loading();
    final result = await repo.getDriverDropdownData();

    result.fold(
      (l) => state = AppState.error(l),
      (r) => state = AppState.success(r),
    );
  }
}