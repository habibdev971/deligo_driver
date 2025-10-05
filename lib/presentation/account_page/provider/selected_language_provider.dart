import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/selected_language_notifier.dart';

final selectedLanguageProvider = StateNotifierProvider<SelectedLanguageNotifier, Locale>(
      (ref,) => SelectedLanguageNotifier(),
);