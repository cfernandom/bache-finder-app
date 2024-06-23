import 'package:bache_finder_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  

  void _login() async {
    final result = await controller.login('fernando@example.com', 'password2024#');
    if (!result) {
      Get.snackbar('Error', 'Failed to login');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Screen'),
            FilledButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
