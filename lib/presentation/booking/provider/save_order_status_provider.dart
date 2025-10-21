import 'package:deligo_driver/data/models/common_response.dart';
import 'package:deligo_driver/presentation/booking/provider/ride_providers.dart';
import 'package:deligo_driver/presentation/booking/view_model/accept_reject_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/app_state.dart';

final saveOrderStatusProvider = StateNotifierProvider<
    SaveOrderStatusNotifier, AppState<CommonResponse>>(
      (ref) => SaveOrderStatusNotifier(
    repo: ref.read(rideRepoProvider), ref: ref,
  ),
);