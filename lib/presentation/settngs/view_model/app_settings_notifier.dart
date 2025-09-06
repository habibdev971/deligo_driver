import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/services/local_storage_service.dart';

class AppSettingsState {
  final bool notificationsEnabled;
  final bool promotionalEnabled;
  final bool vibrationEnabled;

  AppSettingsState({
    required this.notificationsEnabled,
    required this.promotionalEnabled,
    required this.vibrationEnabled,
  });

  AppSettingsState copyWith({
    bool? notificationsEnabled,
    bool? promotionalEnabled,
    bool? vibrationEnabled,
  }) => AppSettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      promotionalEnabled: promotionalEnabled ?? this.promotionalEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
    );
}

class AppSettingsNotifier extends StateNotifier<AppSettingsState> {
  AppSettingsNotifier()
      : super(AppSettingsState(
    notificationsEnabled: false,
    promotionalEnabled: true,
    vibrationEnabled: true,
  )) {
    _loadSettings();
  }

  final _storage = LocalStorageService();

  Future<void> _loadSettings() async{
    checkNotificationStatus();
    state = AppSettingsState(
      notificationsEnabled: await _storage.getNotificationPermission(),
      promotionalEnabled: await _storage.getPromotional(),
      vibrationEnabled: await _storage.getVibration(),
    );
  }

  Future<void> toggleNotification(bool value, BuildContext context) async {
    if (value) {
      // Try requesting permission
      final status = await Permission.notification.request();
      final granted = status.isGranted;

      await _storage.setNotificationPermission(granted);
      state = state.copyWith(notificationsEnabled: granted);

      if (!granted && context.mounted) {
        AppSettings.openAppSettings(type: AppSettingsType.notification);

      }
    } else {
      // Prompt user to go to settings
      if (context.mounted) {
        await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Turn Off Notifications'),
            content: const Text('To fully turn off notifications, please open device settings.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
              TextButton(onPressed: () {
                Navigator.pop(context, true);
                AppSettings.openAppSettings(type: AppSettingsType.notification);
              }, child: const Text('Go')),
            ],
          ),
        );
      }
    }
  }


  Future<void> checkNotificationStatus() async {
    final status = await Permission.notification.status;
    final granted = status.isGranted;
    await _storage.setNotificationPermission(granted);
    state = state.copyWith(notificationsEnabled: granted);
  }


  Future<void> togglePromotional(bool value) async {
    await _storage.setPromotional(value);
    state = state.copyWith(promotionalEnabled: value);
  }

  Future<void> toggleVibration(bool value) async {
    await _storage.setVibration(value);
    state = state.copyWith(vibrationEnabled: value);
  }
}
