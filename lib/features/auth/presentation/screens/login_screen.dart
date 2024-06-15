import 'package:bache_finder_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Screen'),
            Obx(() {
              if (authController.isAuth.value) {
                Future.microtask(() => Get.offAllNamed('/home'));
              }

              return FilledButton(
                  onPressed: () {
                    // TODO: Login
                    const token = 'testToken';
                    authController.login(token);
                  },
                  child: const Text('Login'));
            }),
          ],
        ),
      ),
    );
  }
}
