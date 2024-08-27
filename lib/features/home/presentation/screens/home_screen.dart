import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/gap_widget.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/outlined_button_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends GetView<SessionController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5FB),
      appBar: AppBar(
        title: Text('Bache Finder App', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
        backgroundColor: const Color(0xFF2C5461),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     context.push(AppPaths.profile);
              //   },
              //   child: const Text('Ir a mi perfil'),
              // ),
              const GapWidget(size: 8),
              SizedBox(
                height: 48,
                child: OutlinedButtonIconWidget(
                  onPressed: () {
                    context.push('${AppPaths.potholes}/all');
                  },
                  label: 'Baches reportados',
                  icon: Icons.list_alt,
                ),
              ),
              const GapWidget(size: 8),
              SizedBox(
                height: 48,
                child: OutlinedButtonIconWidget(
                  onPressed: () {
                    context.push('${AppPaths.potholes}/new');
                  },
                  label: 'Reportar bache',
                  icon: Icons.add,
                ),
              ),
              const GapWidget(size: 8),
              ElevatedButtonWidget(
                onPressed: () {
                  controller.logout();
                },
                label: 'Cerrar sesión',
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     context.go(AppPaths.maps);
              //   },
              //   child: const Text('Ir a Maps'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {super.key, required this.onPressed, required this.label});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
