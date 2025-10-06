import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/auth_models/driver_info_state.dart';
import '../view_model/driver_info_notifier.dart';

/// Riverpod provider for DriverInfoNotifier
final driverInfoProvider =
StateNotifierProvider<DriverInfoNotifier, DriverInfoState>(
      (ref) => DriverInfoNotifier(),
);
