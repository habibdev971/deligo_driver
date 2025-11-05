import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/app.dart';
import 'package:deligo_driver/core/widgets/connectivity_wrapper.dart';

import 'data/services/local_storage_service.dart';
import 'data/services/notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await NotificationService().handleBackgroundNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initializeFirebase();
  await dotenv.load();

  await LocalStorageService().init();

  await NotificationService().init();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // ✅ Handle tap when app is terminated
  final RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    //TODO: handle terminated state notification tap here
    // await handleNotificationTap(initialMessage);
  }

  runApp(
    const ProviderScope(
      child: GlobalConnectivityWrapper(child: MyApp()),
    ),
  );
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();
}


