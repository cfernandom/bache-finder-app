import 'package:bache_finder_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/profile');
              },
              child: const Text('Go to Profile'),
            ),
            Obx(() {
              if (!authController.isAuth.value) {
                Future.microtask(() => Get.toNamed('/login'));
              }

              return ElevatedButton(
                onPressed: () {
                  // logout
                  Get.find<AuthController>().logout();
                },
                child: const Text('Logout'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
