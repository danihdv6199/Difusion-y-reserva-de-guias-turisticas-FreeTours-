import 'package:flutter/material.dart';

import 'package:freetour_tfg/features/widgets.dart';

class NotificationProvider {
  static GlobalKey<ScaffoldMessengerState> messegerKey =
      GlobalKey<ScaffoldMessengerState>();

  static successAlert(String message) {
    final snackBar = SnackBar(
        backgroundColor: Colors.green.withOpacity(0.9),
        duration: const Duration(seconds: 4),
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.fixed,
        elevation: 0,
        content: NotificationSnackBar(
          icon: Icons.thumb_up_off_alt,
          color: const Color(0xFF1a512e),
          message: message,
        ));

    messegerKey.currentState!.showSnackBar(snackBar);
  }

  static warningAlert(String message) {
    final snackBar = SnackBar(
        backgroundColor: Colors.amber.withOpacity(0.9),
        elevation: 0,
        duration: const Duration(seconds: 4),
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.fixed,
        content: NotificationSnackBar(
          icon: Icons.warning_amber_outlined,
          color: Colors.amber,
          message: message,
        ));

    messegerKey.currentState!.showSnackBar(snackBar);
  }

  static errorAlert(String message) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red.withOpacity(0.5),
        duration: const Duration(seconds: 4),
        dismissDirection: DismissDirection.startToEnd,
        behavior: SnackBarBehavior.fixed,
        content: NotificationSnackBar(
          icon: Icons.error_outline_outlined,
          color: Colors.redAccent,
          message: message,
        ));

    messegerKey.currentState!.showSnackBar(snackBar);
  }
}
