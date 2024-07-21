import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends GetView<SessionController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push('${AppPaths.potholes}/all');
              },
              child: const Text('Mostrar Baches'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AppPaths.profile);
              },
              child: const Text('Ir a mi perfil'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.logout();
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
