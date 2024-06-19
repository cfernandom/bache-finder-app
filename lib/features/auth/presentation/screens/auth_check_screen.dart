import 'package:bache_finder_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCheckScreen extends GetView<AuthController> {
  const AuthCheckScreen({super.key});
  @override
  Widget build(BuildContext context) {
    controller.isLoading.listen((isLoading) {
      if (!isLoading) {
        if (controller.user.value == null) {
          Get.offAllNamed('/login');
        } else {
          Get.offAllNamed('/');
        }
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
