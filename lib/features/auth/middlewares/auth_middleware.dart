import 'package:bache_finder_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route) {
    final AuthController authController = Get.find();

    if (authController.isAuthLoading.value) {
      return const RouteSettings(name: '/authCheck');
    }

    if (!authController.isAuth.value && route != '/login' && route != '/register') {
      return const RouteSettings(name: '/login');
    }
    return null;
  }
}