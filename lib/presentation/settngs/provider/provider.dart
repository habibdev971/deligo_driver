import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/app_settings_notifier.dart';

final appSettingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettingsState>(
      (ref) => AppSettingsNotifier(),
);