import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:get/get.dart';

class AppRouterController extends GetxController {
  final SessionController sessionController;
  AppRouterController({required this.sessionController});

  @override
  void onInit() {
    super.onInit();
    sessionController.status.listen((status) {
      if (status == SessionStatus.loggedOut) {
        Get.offAllNamed(AppPaths.login);
      } else if (status == SessionStatus.loggedIn) {
        Get.offAllNamed(AppPaths.home);
      }
    });
  }

  String? redirect (String? route) {
    final sessionStatus = sessionController.status.value;
    if (sessionStatus == SessionStatus.checking && route != AppPaths.authCheck) {
      return AppPaths.authCheck;
    }
    if (sessionStatus == SessionStatus.loggedOut && route != AppPaths.login && route != AppPaths.register) {
      return AppPaths.login;
    }
    if (sessionStatus == SessionStatus.loggedIn && (route == AppPaths.login || route == AppPaths.register || route == AppPaths.authCheck)) {
      return AppPaths.home;
    }
    return null;
  }
}
