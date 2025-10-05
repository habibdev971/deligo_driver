import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/localization/country_data.dart';
import '../../../data/services/local_storage_service.dart';

class SelectedLanguageNotifier extends StateNotifier<Locale> {
  final LocalStorageService _storage = LocalStorageService();

  SelectedLanguageNotifier() : super(Locale(allowedLanguages.first['code']!)) {
    _init();
  }
  /// Change language and persist it
  Future<void> changeLanguage(String langCode) async {
    await _storage.selectLanguage(langCode);
    state = Locale(langCode);
  }

  Future<void> _init() async {
    final langCode = await _storage.getSelectedLanguage();
    state = Locale(langCode);
  }
}