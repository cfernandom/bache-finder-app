import 'package:flutter/material.dart';

class SnackbarWidget {
  static void show(BuildContext context, {required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.blueAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class GlobalSnackbarWidget {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void show({required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.blueAccent,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}