import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/validate_session.dart';
import 'package:get/get.dart';

class SessionController extends GetxService {
  final ValidateSession validateSessionUseCase;

  SessionController({
    required this.validateSessionUseCase,
  });

  var session = Rxn<Session>();
  var isLoading = true.obs;

  Future<SessionController> init() async {
    final isValid = await validateSession();
    if (!isValid) {
      Get.offAllNamed(AppRoutes.login);
    }

    return this;
  }

  Future<bool> validateSession() async {
    isLoading.value = true;
    final result = await validateSessionUseCase.call();
    result.fold(
      (failure) => print(failure),
      (session) => this.session.value = session,
    );
    isLoading.value = false;

    return result.isRight();
  }
}
