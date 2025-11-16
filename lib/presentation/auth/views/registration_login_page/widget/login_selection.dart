import 'package:flutter/material.dart';

Widget loginSelection(
    BuildContext context, {
      required bool loginWithPhone,
      required ValueChanged<bool> onChanged,
      bool isLogin = false,
    }) {
  return Visibility(
    visible: isLogin,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Radio<bool>(
            value: false,
            groupValue: loginWithPhone,
            onChanged: (value) => onChanged(value ?? false),
          ),
          const Text("Login with Email"),
          const SizedBox(width: 20),
          Radio<bool>(
            value: true,
            groupValue: loginWithPhone,
            onChanged: (value) => onChanged(value ?? true),
          ),
          const Text("Login with Phone"),
        ],
      ),
    ),
  );
}
