// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ionicons/ionicons.dart';
//
// import '../../../core/routes/app_routes.dart';
// import '../../../core/widgets/app_menu_item.dart';
// import '../provider/provider.dart';
//
// class SettingsPage extends ConsumerStatefulWidget {
//   const SettingsPage({super.key});
//
//   @override
//   ConsumerState<SettingsPage> createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends ConsumerState<SettingsPage> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     ref.read(appSettingsProvider.notifier);
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       ref.read(appSettingsProvider.notifier).checkNotificationStatus();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final settings = ref.watch(appSettingsProvider);
//     final notifier = ref.read(appSettingsProvider.notifier);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('App Settings')),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
//             child: AppMenuItem(
//               icon: Ionicons.globe,
//               title: 'Language Settings',
//               onPressed: () {
//                 Navigator.pushNamed(context, AppRoutes.languageSettingsPage);
//               },
//             ),
//           ),
//           SwitchListTile(
//             title: const Text('Notification Permission'),
//             value: settings.notificationsEnabled,
//             onChanged: (v) {
//               notifier.toggleNotification(v, context);
//             },
//           ),
//           SwitchListTile(
//             title: const Text('Promotional Notifications'),
//             value: settings.promotionalEnabled,
//             onChanged: notifier.togglePromotional,
//           ),
//           SwitchListTile(
//             title: const Text('Vibration'),
//             value: settings.vibrationEnabled,
//             onChanged: notifier.toggleVibration,
//           ),
//         ],
//       ),
//     );
//   }
// }
