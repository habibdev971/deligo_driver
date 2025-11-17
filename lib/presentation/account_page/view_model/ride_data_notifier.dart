import 'package:deligo_driver/core/state/app_state.dart';
import 'package:deligo_driver/data/repositories/interfaces/auth_repo_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/ride_data_model/Driver.dart';

class RideDataNotifier extends StateNotifier<AppState<RideDataCount?>>{
  final Ref ref;
  final IAuthRepo repo;
  RideDataNotifier({required this.ref, required this.repo}) : super(const AppState.initial());

  Future<void> getRideData() async {
    state = const AppState.loading();
    final response = await repo.getRideData();
    response.fold(
      (failure) => state = AppState.error(failure),
      (rideData) => state = AppState.success(rideData.data?.driver),
    );

  }
}