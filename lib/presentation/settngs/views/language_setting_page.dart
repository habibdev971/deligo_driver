// import 'package:flutter/material.dart';
// import 'package:deligo_driver/core/extensions/extensions.dart';
// import 'package:deligo_driver/presentation/auth/widgets/language_list.dart';
//
// import '../../../core/widgets/responsive_dialog/app_top_bar.dart';
// import '../../../data/models/language.dart';
//
// class LanguageSettingPage extends StatelessWidget {
//   const LanguageSettingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) => Container(
//       color: context.theme.scaffoldBackgroundColor,
//       padding: EdgeInsets.symmetric(
//         horizontal: context.responsive(16, xl: 24),
//         vertical: context.responsive(
//           16,
//           xl: 24,
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             context.responsive(
//               const SizedBox(),
//               xl: const SizedBox(
//                 height: 80,
//               ),
//             ),
//             const AppTopBar(title: 'Language Settings'),
//             const SizedBox(
//               height: 16,
//             ),
//             Expanded(
//               child: LanguageList(
//                 selectedLanguageCode: 'en',
//                 onPressed: (Language language) {},
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
// }
