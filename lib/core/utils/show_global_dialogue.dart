import 'package:flutter/material.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';

void showGlobalAlertDialog({
  required Widget child
}) {
  final context = NavigationService.navigatorKey.currentContext;
  if (context == null) return;

  showDialog(
    context: context,
    builder: (_) => child,
    barrierDismissible: false,

  );
}
