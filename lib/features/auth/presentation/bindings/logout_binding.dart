import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/logout_controller.dart';
import 'package:get/get.dart';

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Logout>(
      () => Logout(Get.find()),
    );

    Get.lazyPut<LogoutController>(
      () => LogoutController(
        logoutUseCase: Get.find(),
      ),
    );
  }
}
