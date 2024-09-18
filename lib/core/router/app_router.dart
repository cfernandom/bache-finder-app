import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/auth/presentation/bindings/login_binding.dart';
import 'package:bache_finder_app/features/auth/presentation/bindings/register_binding.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/auth_check_screen.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/login_screen.dart';
import 'package:bache_finder_app/features/auth/presentation/screens/register_screen.dart';
import 'package:bache_finder_app/features/home/presentation/screens/home_screen.dart';
import 'package:bache_finder_app/features/pothole/presentation/bindings/pothole_binding.dart';
import 'package:bache_finder_app/features/pothole/presentation/bindings/potholes_binding.dart';
import 'package:bache_finder_app/features/pothole/presentation/screens/pothole_screen.dart';
import 'package:bache_finder_app/features/pothole/presentation/screens/potholes_screen.dart';
import 'package:bache_finder_app/features/pothole/presentation/widgets/location_picker_widget.dart';
import 'package:bache_finder_app/features/sample/google_maps.dart';
import 'package:bache_finder_app/features/user/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter createRouter(AppRouterNotifier appRouterNotifier) {
    return GoRouter(
        initialLocation: AppPaths.authCheck,
        refreshListenable: RxNotifier(appRouterNotifier.status),
        routes: [
          GoRoute(
            path: AppPaths.authCheck,
            name: 'authCheck',
            builder: (context, state) {
              Get.find<SessionController>().validateSession();
              return const AuthCheckScreen();
            },
          ),
          GoRoute(
            path: AppPaths.login,
            name: 'login',
            builder: (context, state) {
              LoginBinding().removeDependencies();
              LoginBinding().dependencies();
              return const LoginScreen();
            },
            onExit: (context, state) {
              return true;
            },
          ),
          GoRoute(
            path: AppPaths.register,
            name: 'register',
            builder: (context, state) {
              RegisterBinding().dependencies();
              return const RegisterScreen();
            },
            onExit: (context, state) {
              RegisterBinding().removeDependencies();
              return true;
            },
          ),
          GoRoute(
            path: AppPaths.home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppPaths.profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '${AppPaths.potholes}/:potholeId',
            name: 'potholes',
            onExit: (context, state) {
              if (state.pathParameters['potholeId'] == 'all') {
                PotholesBinding().removeDependencies();
              } else {
                PotholeBinding(potholeId: state.pathParameters['potholeId']!)
                    .removeDependencies();
              }
              return true;
            },
            builder: (context, state) {
              if (state.pathParameters['potholeId'] == 'all') {
                PotholesBinding().dependencies();
                return const PotholesScreen();
              }

              PotholeBinding(
                potholeId: state.pathParameters['potholeId'] ?? 'new',
              ).dependencies();

              return const PotholeScreen();
            },
            routes: [
              GoRoute(
                path: AppPaths.locationPicker,
                name: 'locationPicker',
                builder: (context, state) => const LocationPickerScreen(),
                onExit: (context, state) {
                  Get.delete<LocationPickerController>();
                  return true;
                },
              ),
            ],
          ),
        ],
        redirect: (context, state) {
          final isGoinTo = state.matchedLocation;
          final sessionStatus = appRouterNotifier.status.value;

          if (isGoinTo == AppPaths.authCheck &&
              sessionStatus == SessionStatus.checking) {
            return null;
          }

          if (sessionStatus == SessionStatus.checking) {
            return AppPaths.authCheck;
          }

          if (sessionStatus == SessionStatus.loggedOut) {
            if (isGoinTo == AppPaths.login || isGoinTo == AppPaths.register) {
              return null;
            }
            return AppPaths.login;
          }

          if (sessionStatus == SessionStatus.loggedIn) {
            if (isGoinTo == AppPaths.login ||
                isGoinTo == AppPaths.register ||
                isGoinTo == AppPaths.authCheck) {
              return AppPaths.home;
            }
            return null;
          }

          return null;
        });
  }
}

class AppRouterNotifier extends GetxController {
  final SessionController _sessionController = Get.find();

  Rx<SessionStatus> get status => _sessionController.status;

  AppRouterNotifier() {
    _sessionController.status.listen((state) {
      update();
    });
  }
}

class RxNotifier<T> extends ChangeNotifier {
  final Rx<T> _rx;

  RxNotifier(this._rx) {
    _rx.listen((_) {
      notifyListeners();
    });
  }
}
