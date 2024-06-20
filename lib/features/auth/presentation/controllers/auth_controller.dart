import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/entities/user.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/validate_session.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final Login loginUseCase;
  final Logout logoutUseCase;
  final ValidateSession validateSessionUseCase;

  AuthController({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.validateSessionUseCase,
  });

  var session = Rxn<Session>();
  var user = Rxn<User>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    validateSession();
  }

  Future<bool> validateSession() async {
    isLoading.value = true;
    final result = await validateSessionUseCase.call();
    result.fold(
      (failure) => print(failure),
      (user) => this.user.value = user,
    );
    isLoading.value = false;

    return result.isRight();
  }

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUseCase.call(email, password);
    result.fold(
      (failure) => print(failure),
      (session) => this.session.value = session,
    );
    isLoading.value = false;

    return result.isRight();
  }

  Future<void> logout() async {
    isLoading.value = true;
    user.value = null;
    await logoutUseCase.call();
    isLoading.value = false;
  }
}
