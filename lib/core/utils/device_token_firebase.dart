import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

FutureOr<String?> deviceTokenFirebase()async =>  Platform.isIOS ? await FirebaseMessaging.instance.getAPNSToken() : await FirebaseMessaging.instance.getToken();