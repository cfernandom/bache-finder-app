import 'package:bache_finder_app/features/auth/presentation/controllers/forms/login_form_controller.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginFormController(
        login: Get.find<SessionController>().login,
      ),
    );
  }
}