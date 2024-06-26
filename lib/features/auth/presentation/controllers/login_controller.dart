import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final Login _loginUseCase;

  LoginController({required Login loginUseCase}) : _loginUseCase = loginUseCase;

  var isLoading = true.obs;
  final sessionController = Get.find<SessionController>();

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    final result = await _loginUseCase.call(email, password);

    result.fold(
      (failure) => print(failure),
      (session) => sessionController.session.value = session,
    );

    isLoading.value = false;
    sessionController.status.value =
        result.isRight() ? SessionStatus.loggedIn : SessionStatus.loggedOut;

    return result.isRight();
  }
}
