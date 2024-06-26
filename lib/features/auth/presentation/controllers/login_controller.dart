import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final Login _loginUseCase;

  LoginController({required Login loginUseCase}) : _loginUseCase = loginUseCase;

  final _isLoading = true.obs;
  final _sessionController = Get.find<SessionController>();

  bool get isLoading => _isLoading.value;

  Future<bool> login(String email, String password) async {
    _isLoading.value = true;
    final result = await _loginUseCase.call(email, password);

    result.fold(
      (failure) => print(failure),
      (session) => _sessionController.session.value = session,
    );

    _isLoading.value = false;
    _sessionController.status.value =
        result.isRight() ? SessionStatus.loggedIn : SessionStatus.loggedOut;

    return result.isRight();
  }
}
