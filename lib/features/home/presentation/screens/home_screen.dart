import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/logout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<LogoutController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppPaths.profile);
              },
              child: const Text('Go to Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.logout();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
