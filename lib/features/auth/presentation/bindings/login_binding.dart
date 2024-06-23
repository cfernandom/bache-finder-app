import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Login>(
      () => Login(Get.find()),
    );

    Get.lazyPut<LoginController>(
      () => LoginController(
        loginUseCase: Get.find(),
      ),
    );
  }
}