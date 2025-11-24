import 'package:deligo_driver/data/models/common_response.dart';
import 'package:deligo_driver/data/models/ride_details_model/RideDetailsModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/data/repositories/ride_repo_impl.dart';
import 'package:deligo_driver/data/services/ride_service.dart';
import 'package:deligo_driver/domain/interfaces/ride_service_interface.dart';
import 'package:deligo_driver/data/repositories/interfaces/ride_repo_interface.dart';

import '../../../core/state/app_state.dart';
import '../../../core/state/state_order.dart';
import '../../../data/models/order_response/order_model/order/order.dart';
import '../../../data/models/request_accept_model/OrderAcceptModel.dart';
import '../../auth/provider/auth_providers.dart';
import '../view_model/accept_reject_notifier.dart';
import '../view_model/ride_notifier_provider.dart';

// RideService Provider (depends on Dio)
final rideServiceProvider = Provider<IRideService>(
  (ref) => RideService(dioClient: ref.read(dioClientProvider)),
);

// RideRepo Provider (depends on RideService)
final rideRepoProvider = Provider<IRideRepo>(
  (ref) => RideRepoImpl(rideService: ref.read(rideServiceProvider)),
);

final rideRequestDetailProvider = StateNotifierProvider<
    RideOrderNotifier, AppState<RideRequest?>>(
  (ref) => RideOrderNotifier(
    ref: ref,
    rideRepo: ref.read(rideRepoProvider),
  ),
);

final tripActivityNotifierProvider = StateNotifierProvider<
    CheckTripActivityNotifier, AppState<Order?>>(
      (ref) => CheckTripActivityNotifier(
        ref.read(rideRepoProvider), ref,
  ),
);

final acceptRejectProvider = StateNotifierProvider<
    AcceptRejectNotifier, AppState<OrderAcceptModel>>(
      (ref) => AcceptRejectNotifier(
    repo: ref.read(rideRepoProvider), ref: ref,
  ),
);

final rideDetailsProvider = StateNotifierProvider<
    RideDetailsNotifier, AppState<RideRequest?>>(
      (ref) => RideDetailsNotifier(
    repo: ref.read(rideRepoProvider), ref: ref,
  ),
);