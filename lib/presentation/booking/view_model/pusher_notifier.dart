import 'dart:convert';

import 'package:deligo_driver/data/models/order_response/pusher_order/PusherRequestOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:deligo_driver/core/routes/app_routes.dart';
import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/data/models/chat_message_response/chat_message.dart';
import 'package:vibration/vibration.dart';

import '../../../data/services/local_storage_service.dart';
import '../../../data/services/navigation_service.dart';
import '../../../data/services/pusher_service.dart';
import '../../home_page/widgets/order_request_dialogue.dart';
import '../provider/chat_provider.dart';
import '../provider/driver_providers.dart';
import '../provider/home_providers.dart';

class PusherNotifier extends StateNotifier<void> {
  final Ref ref;

  PusherNotifier(this.ref) : super(null);

  /// Setup pusher and subscribe to necessary channels
  Future<void> setupPusherListeners() async {
    final int? driverId = await LocalStorageService().getUserId();
    final String orderChannel = 'driver-$driverId';

    await PusherService().init(
      onEvent: (event) {
        _handlePusherEvent(event, driverId, orderChannel);
      },
    );

    /// Subscribe to global & private driver channels
    await PusherService().subscribeChannel(orderChannel);
  }

  /// Handle incoming pusher event
  Future<void> _handlePusherEvent(
    PusherEvent event,
    int? driverId,
    String orderChannel,
  ) async {
    Map<String, dynamic> eventData = {};
    try {
      if (event.data is String) {
        eventData = Map<String, dynamic>.from(jsonDecode(event.data!));
      } else {}
    } catch (e) {
      if (true) {}
    }

    if (eventData.isEmpty) {
      return;
    }

    final chatChannel = 'chat_$driverId';

    if (event.channelName.contains(chatChannel)) {
      _handleChatMessages(eventData);
    } else if (event.channelName.contains(orderChannel)) {
      playRingtone();
      final PusherRequestOrderModel model = PusherRequestOrderModel.fromJson(eventData);

      final orderId = model.rideRequestId;
      await LocalStorageService().saveOrderId(orderId?.toInt());
      orderRequestDialogue(data: model);
          // ref.read(driverStatusNotifierProvider.notifier)
          // .orderRequest(data: {'order_id': orderId});
          return;
      // if (eventData.containsKey('data')) {
      //   final data = eventData['data'];
      //   if (data is Map && data.containsKey('order_id')) {
      //     final int? orderId = data['order_id'];
      //     playRingtone();
      //     await LocalStorageService().saveOrderId(orderId);
      //     ref
      //         .read(driverStatusNotifierProvider.notifier)
      //         .orderRequest(data: {'order_id': orderId});
      //   }
      // }
    } else if (event.channelName.contains(
      'order.${await LocalStorageService().getOrderId()}.$driverId',
    )) {
      playRingtone();
      await PusherService().unsubscribeChannel(
        'order.${await LocalStorageService().getOrderId()}.$driverId',
      );
      showNotification(message: 'Your Ride has been cancel by Rider!');
      final local = LocalStorageService();
      await local.clearOrderId();
      ref.read(bookingNotifierProvider.notifier).resetToInitial();
      NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
    }
  }

  Future<void> _handleChatMessages(Map<String, dynamic> data) async {
    final trackOrderState = ref.read(ontripStatusNotifier);
    final message = Message.fromJson(data, convertPusher: true);
    trackOrderState.maybeWhen(
      chat: () {
        ref.read(chatNotifierProvider.notifier).addMessage(message);
      },
      orElse: () {
        playRingtone();
        _showChatSnackBar(message);
      },
    );
  }

  /// Disconnect and unsubscribe from all channels
  Future<void> disconnect() async {
    await PusherService().disconnectAndUnsubscribeAll();
  }

  /// Fully reset Pusher
  Future<void> reset() async {
    await PusherService().reset();
  }

  /// Play local notification sound
  void playRingtone() {
    FlutterRingtonePlayer().play(
      fromAsset: 'assets/notification2.mp3',
      looping: false,
      volume: 1.0,
      asAlarm: true,
    );
    vibratePhone();
  }

  Future<void> vibratePhone() async {
    // Check if vibration is enabled from local storage
    final isVibrationEnabled = await LocalStorageService().getVibration();

    if (isVibrationEnabled) {
      // If vibration is enabled, vibrate the phone
      if (await Vibration.hasCustomVibrationsSupport()) {
        Vibration.vibrate(
          duration: 2000,
        ); // Vibrate for 2 seconds if custom vibrations are supported
      } else {
        Vibration.vibrate(); // Default vibration
        await Future.delayed(
          const Duration(milliseconds: 500),
        ); // Pause for 500ms
        Vibration.vibrate(); // Vibrate again
      }
    }
  }

  void _showChatSnackBar(Message message) {
    final context = NavigationService.navigatorKey.currentContext;
    if (context == null) return;

    const sender = 'Rider';
    final msgText = message.message;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.white),
            children: [
              const TextSpan(
                text: '$sender: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: msgText),
            ],
          ),
        ),
        action: SnackBarAction(
          label: 'See',
          onPressed: () {
            ref.read(ontripStatusNotifier.notifier).goToChat();
          },
          textColor: Colors.yellowAccent,
        ),

        backgroundColor: Colors.green,
        duration: const Duration(seconds: 6),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
