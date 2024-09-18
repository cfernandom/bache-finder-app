import 'package:bache_finder_app/features/auth/presentation/controllers/forms/register_form_controller.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegisterFormController(
        registerCallback: Get.find<SessionController>().register,
      ),
    );
  }

  void removeDependencies() {
    Get.delete<RegisterFormController>();
  }
}