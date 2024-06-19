import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/features/auth/auth_binding.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/auth_check_screen.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/login_screen.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/register_screen.dart';
import 'package:bache_finder_app/features/home/presentation/screens/home_screen.dart';
import 'package:bache_finder_app/features/report/presentation/screens/report_screen.dart';
import 'package:bache_finder_app/features/shared/main_binding.dart';
import 'package:bache_finder_app/features/user/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await Enviroment.initEnviroment();
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
      initialBinding: MainBinding(),
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen(), binding: AuthBinding()),
        GetPage(name: '/login', page: () => const LoginScreen(), binding: AuthBinding()),
        GetPage(name: '/authCheck', page: () => const AuthCheckScreen(), binding: AuthBinding()),
        GetPage(name: '/register', page: () => const RegisterScreen(), binding: AuthBinding()),
        GetPage(name: '/report', page: () => const ReportScreen()),
        GetPage(
          name: '/profile',
          page: () => const ProfileScreen(),
        ),
      ],
    );
  }
}