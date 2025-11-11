import 'package:deligo_driver/data/repositories/interfaces/ride_history_repo_interface.dart';
import 'package:deligo_driver/data/repositories/ride_history_repo_impl.dart';
import 'package:deligo_driver/data/services/ride_history_service.dart';
import 'package:deligo_driver/domain/interfaces/ride_history_service_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/provider/auth_providers.dart';
import '../view_model/ride_history_notifier.dart';

final rideHistoryServiceProvider = Provider<IRideHistoryService>(
      (ref) => RideHistoryService(dioClient: ref.read(dioClientProvider)),
);

// Repo Provider
final rideHistoryRepoProvider = Provider<IRideHistoryRepo>(
      (ref) => RideHistoryRepoImpl(rideHistoryService: ref.read(rideHistoryServiceProvider)),
);

final rideHistoryProvider =
StateNotifierProvider<RideHistoryNotifier, RideHistoryState>((ref) {
  final repo = ref.watch(rideHistoryRepoProvider);
  return RideHistoryNotifier(ref: ref, repo: repo);
});
