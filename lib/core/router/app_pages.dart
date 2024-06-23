import 'package:bache_finder_app/core/middlewares/auth_middleware.dart';
import 'package:bache_finder_app/features/auth/presentation/bindings/auth_binding.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/auth_check_screen.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/login_screen.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/register_screen.dart';
import 'package:bache_finder_app/features/home/presentation/screens/home_screen.dart';
import 'package:bache_finder_app/features/report/presentation/screens/report_screen.dart';
import 'package:bache_finder_app/features/user/presentation/screens/profile_screen.dart';
import 'package:get/get.dart';

class AppPaths {
  static const String login = '/login';
  static const String register = '/register';
  static const String authCheck = '/authCheck';
  static const String report = '/report';
  static const String home = '/';
  static const String profile = '/profile';
}

class AppRouter {
  static final List<GetPage> routes = [
    GetPage(
      name: AppPaths.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppPaths.register,
      page: () => const RegisterScreen(),

    ),
    GetPage(
      name: AppPaths.authCheck,
      page: () => const AuthCheckScreen(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppPaths.report,
      page: () => const ReportScreen(),
    ),
    GetPage(
      name: AppPaths.home,
      page: () => const HomeScreen(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppPaths.profile,
      page: () => const ProfileScreen(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
