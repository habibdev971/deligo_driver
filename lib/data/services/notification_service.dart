import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'local_storage_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // ✅ Create Notification Channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // ✅ Initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // ✅ Request permissions (iOS)
    await FirebaseMessaging.instance.requestPermission();

    // ✅ Listen for foreground messages only (show notification)
    FirebaseMessaging.onMessage.listen((message) {
      log('[onMessage] ${message.data}');
      showFirebaseNotification(message);
    });

    // ✅ Listen for notification taps (don’t show notification again)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('[onMessageOpenedApp] ${message.data}');
      handleNotificationTap(message);
    });
  }

  /// ✅ Show local notification (used only for foreground)
  Future<void> showFirebaseNotification(RemoteMessage message) async {
    // We only show if notification OR data exists
    if (message.notification == null && message.data.isEmpty) return;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics =
    DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? message.data['title'] ?? 'New Notification',
      message.notification?.body ?? message.data['body'] ?? '',
      platformChannelSpecifics,
    );
  }

  /// ✅ Background handler should not show notification again
  Future<void> handleBackgroundNotification(RemoteMessage message) async {
    log('[Background Message] ${message.data}');
    await handleNotificationTap(message);
  }

  /// ✅ Custom notification (for manual use)
  Future<void> showCustomNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics =
    DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}

/// ✅ Handle Notification Tap — shared across all states
Future<void> handleNotificationTap(RemoteMessage message) async {
  final locale = LocalStorageService();
  final data = message.data;

  log(data.toString());
  if (data.isEmpty) return;
  // await locale.clearRemoteMessage();

  // delayShowMessage( show: (){
  //   showNotification(message: 'Notification tapped data: ${data.toString()}');
  // });
  if (data['notification_type'] != 'ride_request_to_driver') return;
  if(data['notification_send_time'] != null){
    final orderId = int.tryParse(data['order_id'].toString());
    final sentTime = DateTime.tryParse(data['notification_send_time'] ?? '');

  }


  // final orderStatus = data['order_status'];
  //
  //
  // if (orderId == null) {
  //   log('❌ Invalid order_id in notification data');
  //   return;
  // }
  //
  // // 🕒 30s expiry check
  // if (sentTime != null) {
  //   final now = DateTime.now().toUtc();
  //   final difference = now.difference(sentTime).inSeconds;
  //   if (difference > 30) {
  //     log('⚠️ Order request expired (order_id: $orderId)');
  //     // delayShowMessage(show: () {
  //     //   showNotification(
  //     //     message:
  //     //     '⚠️ Order expired (order_id: $orderId). Sent at: $sentTime, diff: $difference sec',
  //     //   );
  //     // }, seconds: 8);
  //     return;
  //   }
  // }

  // try {
  //   log('✅ Handling order request from notification...');
  //   log('Order ID: $orderId');
  //   log('Order Status: $orderStatus');
  //   log('Sent Time: $sentTime');
  //
  //   // final msg = RemoteMessageModel.fromJson(message.data);
  //   // await LocalStorageService().saveRemoteMessage(msg: msg.toJson());
  //   // delayShowMessage(show: (){
  //   //   showNotification(message: '✅ Order request handled successfully and saved',);
  //   // }, seconds: 10);
  //   // TODO: এখানে তুমি তোমার Riverpod provider বা dialogue trigger করবে
  // } catch (e) {
  //   // delayShowMessage(show: (){
  //   //   showNotification(message: '❌ Error while handling order request: $e');
  //   // });
  //   log('❌ Error while handling order request: $e');
  // }
}
