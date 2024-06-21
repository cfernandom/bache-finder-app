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

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUseCase.call(email, password);
    result.fold(
      (failure) => print(failure),
      (session) => Get.find<SessionController>().session.value = session,
    );
    isLoading.value = false;

    return result.isRight();
  }

  Future<void> logout() async {
    isLoading.value = true;
    await logoutUseCase.call();
    isLoading.value = false;
  }
}
