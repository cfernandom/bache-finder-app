import 'package:bache_finder_app/features/auth/presentation/controllers/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCheckScreen extends GetView<LogoutController> {
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
