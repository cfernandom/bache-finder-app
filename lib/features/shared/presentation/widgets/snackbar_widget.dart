import 'package:flutter/material.dart';

class SnackbarWidget {
  static void show(BuildContext context, {required String message}) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: Colors.blueAccent,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
