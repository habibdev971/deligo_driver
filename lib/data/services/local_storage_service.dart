import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:deligo_driver/core/extensions/storage_safe_read.dart';
import '../models/hive_models/user_hive_model.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _languageKey = 'language';

  final ValueNotifier<String> languageNotifier = ValueNotifier('en');

  Future<void> init() async {
    final lang = await _storage.safeRead(key: _languageKey);
    languageNotifier.value = lang ?? 'en';
  }

  Future<void> selectLanguage(String language) async {
    await _storage.write(key: _languageKey, value: language);
    languageNotifier.value = language;
  }

  Future<String> getSelectedLanguage() async => await _storage.safeRead(key: _languageKey) ?? 'en';

  void setTheme(String mode) {
    _storage.write(key: 'themeMode', value: mode);
  }

  Future<String> getThemeMode() async => await _storage.safeRead(key: 'themeMode') ?? 'light';

  Future<void> saveUser({required Map<String, dynamic>? data}) async {
    if (data != null) {
      final model = UserHiveModel.fromMap(data);
      final encoded = jsonEncode(model.toMap());
      await _storage.write(key: 'user', value: encoded);

      setOnlineOffline(model.driverStatus?.toLowerCase() == 'online');
    }
  }

  void setRegistrationProgress(String pageName) {
    _storage.write(key: 'registration', value: pageName);
  }

  Future<String?> getRegistrationProgress() => _storage.safeRead(key: 'registration');

  Future<void> setOnlineOffline([bool isOnline = false]) async {
    await _storage.write(key: 'activity', value: isOnline.toString());
  }

  Future<bool> getOnlineOffline() async {
    final value = await _storage.safeRead(key: 'activity');
    return value == 'true';
  }

  Future<UserHiveModel?> getSavedUser() async {
    final json = await _storage.safeRead(key: 'user');
    if (json != null) {
      final map = jsonDecode(json);
      return UserHiveModel.fromMap(Map<String, dynamic>.from(map));
    }
    return null;
  }

  Future<int?> getUserId() async {
    final user = await getSavedUser();
    return user?.id;
  }

  Future<void> saveToken(String? token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async => _storage.safeRead(key: 'token');

  Future<void> clearToken() async {
    await _storage.delete(key: 'token');
  }

  Future<void> clearUser() async {
    await _storage.delete(key: 'user');
  }

  Future<void> completeOnboarding() async {
    await _storage.write(key: 'onboarding', value: 'true');
  }

  Future<bool> isCompletedOnboarding() async {
    final value = await _storage.safeRead(key: 'onboarding');
    return value == 'true';
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.safeRead(key: 'token');
    return token != null;
  }

  Future<void> saveChatState({required bool isOpen}) async {
    await _storage.write(key: 'chat-state', value: isOpen.toString());
  }

  Future<bool> getChatState() async {
    final value = await _storage.safeRead(key: 'chat-state');
    return value == 'true';
  }

  Future<void> saveOrderId(int? id) async {
    await _storage.write(key: 'order_id', value: id?.toString());
  }

  Future<int?> getOrderId() async {
    final value = await _storage.safeRead(key: 'order_id');
    return value != null ? int.tryParse(value) : null;
  }

  Future<void> clearOrderId() async {
    await _storage.delete(key: 'order_id');
  }

  Future<void> saveCountryCode(String countryCode) async {
    await _storage.write(key: 'country-code', value: countryCode);
  }

  Future<String> getCountryCode() async {
    final value = await _storage.safeRead(key: 'country-code');
    return value ?? '+880';
  }

  /// ---------------- App settings ----------------

  static const String _promotionalKey = 'promotional_enabled';
  static const String _vibrationKey = 'vibration_enabled';
  static const String _notificationsKey = 'notifications_enabled';

  Future<void> setPromotional(bool value) async {
    await _storage.write(key: _promotionalKey, value: value.toString());
  }

  Future<bool> getPromotional() async {
    final value = await _storage.safeRead(key: _promotionalKey);
    return value == null ? true : value == 'true';
  }

  Future<void> setVibration(bool value) async {
    await _storage.write(key: _vibrationKey, value: value.toString());
  }

  Future<bool> getVibration() async {
    final value = await _storage.safeRead(key: _vibrationKey);
    return value == null ? true : value == 'true';
  }

  Future<void> setNotificationPermission(bool granted) async {
    await _storage.write(key: _notificationsKey, value: granted.toString());
  }

  Future<bool> getNotificationPermission() async {
    final value = await _storage.safeRead(key: _notificationsKey);
    return value == 'true';
  }

  /// ---------------- Clear Storage ----------------

  Future<void> clearStorage() async {
    await clearToken();
    await clearUser();
  }

  Future<void> destroyAll() async {
    await clearToken();
    await clearUser();
    await clearOrderId();
  }
}
