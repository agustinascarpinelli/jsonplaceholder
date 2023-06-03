import 'package:flutter/material.dart';

class Notifications {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String message) {
    final snackbar = SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(message,
            style: const TextStyle(color: Colors.white, fontSize: 20)));
    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
