import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:get/get.dart';

class LogoutController extends GetxController {
  final Logout logoutUseCase;

  LogoutController({
    required this.logoutUseCase,
  });

  var isLoading = true.obs;
  final sessionController = Get.find<SessionController>();

  Future<void> logout() async {
    isLoading.value = true;
    await logoutUseCase.call();
    sessionController.session.value = null;
    sessionController.status.value = SessionStatus.loggedOut;
    isLoading.value = false;
  }
}
