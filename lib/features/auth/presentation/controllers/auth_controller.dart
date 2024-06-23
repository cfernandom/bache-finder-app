import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final Login loginUseCase;
  final Logout logoutUseCase;

  AuthController({
    required this.loginUseCase,
    required this.logoutUseCase,
  });

  var isLoading = true.obs;
  final sessionController = Get.find<SessionController>();

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUseCase.call(email, password);
    result.fold(
      (failure) => print(failure),
      (session) => sessionController.session.value = session,
    );
    isLoading.value = false;
    sessionController.status.value = result.isRight() ? SessionStatus.loggedIn : SessionStatus.loggedOut;

    return result.isRight();
  }

  Future<void> logout() async {
    isLoading.value = true;
    await logoutUseCase.call();
    sessionController.session.value = null;
    sessionController.status.value = SessionStatus.loggedOut;
    isLoading.value = false;
  }
}
