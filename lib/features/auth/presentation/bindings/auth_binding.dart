import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Login>(
      () => Login(Get.find()),
    );

    Get.lazyPut<Logout>(
      () => Logout(Get.find()),
    );

    Get.lazyPut<AuthController>(
      () => AuthController(
        loginUseCase: Get.find(),
        logoutUseCase: Get.find(),
      ),
    );
  }
}
