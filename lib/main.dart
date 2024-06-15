import 'package:bache_finder_app/features/auth/controllers/auth_controller.dart';
import 'package:bache_finder_app/features/auth/middlewares/auth_middleware.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/auth_check_screen.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/login_screen.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/register_screen.dart';
import 'package:bache_finder_app/features/home/presentation/screens/home_screen.dart';
import 'package:bache_finder_app/features/report/presentation/screens/report_screen.dart';
import 'package:bache_finder_app/features/user/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bache Finder App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/authCheck',
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
      getPages: [
        GetPage(name: '/home', page: () => const HomeScreen(), middlewares: [AuthMiddleware()]),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/authCheck', page: () => const AuthCheckScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/report', page: () => const ReportScreen()),
        GetPage(
          name: '/profile',
          page: () => const ProfileScreen(),
          middlewares: [AuthMiddleware()],
        ),
      ],
    );
  }
}