// import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
// import 'package:deligo_driver/core/utils/localize.dart';
// import 'package:deligo_driver/presentation/auth/widgets/auth_app_bar.dart';
// import 'package:deligo_driver/presentation/auth/widgets/register_fields.dart';
// import 'package:flutter/material.dart';
//
// class RegistrationPage extends StatefulWidget {
//   const RegistrationPage({super.key});
//
//   @override
//   State<RegistrationPage> createState() => _RegistrationPageState();
// }
//
// class _RegistrationPageState extends State<RegistrationPage> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//
//   @override
//   void dispose() {
//     super.dispose();
//     firstNameController.dispose();
//     lastNameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     passwordController.dispose();
//     genderController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) => ExitAppWrapper(
//
//       child: Scaffold(
//         body: AuthAppBar(
//           title: 'register',
//           showLeading: false,
//           child: Form(
//               key: _formKey,
//               child: registrationLoginFields(context, firstNameController: firstNameController, lastNameController: lastNameController, emailController: emailController, phoneController: phoneController, passwordController: passwordController, genderController: genderController)),
//         ),
//       ),
//     );
// }
