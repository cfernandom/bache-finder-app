import 'package:flutter/material.dart';

class AuthCheckScreen extends StatelessWidget {
  const AuthCheckScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
