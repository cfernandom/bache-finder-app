import 'package:bache_finder_app/features/auth/presentation/screens/auth_check_screen.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/login_screen.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/register_screen.dart';
import 'package:bache_finder_app/features/home/presentation/screens/home_screen.dart';
import 'package:bache_finder_app/features/report/presentation/screens/report_screen.dart';
import 'package:bache_finder_app/features/user/presentation/screens/profile_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const authCheck = '/authCheck';
  static const report = '/report';
  static const home = '/home';
  static const profile = '/profile';
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.authCheck,
      page: () => const AuthCheckScreen(),
    ),
    GetPage(
      name: AppRoutes.report,
      page: () => const ReportScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
    ),
  ];
}