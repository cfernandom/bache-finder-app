import 'package:bache_finder_app/core/router/app_router_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final AppRouterController _appRouterController = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    final redirectRoute = _appRouterController.redirect(route);
    return redirectRoute == null ? null : RouteSettings(name: redirectRoute);
  }
}
