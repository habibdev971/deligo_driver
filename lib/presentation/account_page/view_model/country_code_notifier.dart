import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';

import '../../../core/config/localization/country_data.dart';

class SelectedPhoneCodeNotifier extends StateNotifier<String> {
  final LocalStorageService _storage = LocalStorageService();

  SelectedPhoneCodeNotifier() : super(allowedPhoneCodes.first['phone_code']!) {
    _init();
  }

  /// Change phone code and persist it
  Future<void> changePhoneCode(String phoneCode) async {
    phoneCode = phoneCode.contains('+880')
        ? phoneCode.replaceAll('0', '')
        : phoneCode;
    await _storage.savePhoneCode(phoneCode);
    state = phoneCode;
  }

  Future<void> _init() async {
    final storedCode = await _storage.getPhoneCode();
    state = storedCode;
  }
}
