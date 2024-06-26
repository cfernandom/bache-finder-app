import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/validate_session.dart';
import 'package:get/get.dart';

enum SessionStatus {
  loggedOut,
  loggedIn,
  checking,
}

class SessionController extends GetxService {
  final ValidateSession _validateSessionUseCase;

  SessionController({
    required ValidateSession validateSessionUseCase,
  }) : _validateSessionUseCase = validateSessionUseCase;

  var session = Rxn<Session>();
  var status = SessionStatus.checking.obs;

  Future<bool> validateSession() async {
    final result = await _validateSessionUseCase.call();
    result.fold(
      (failure) => print(failure),
      (session) => this.session.value = session,
    );

    status.value =
        result.isRight() ? SessionStatus.loggedIn : SessionStatus.loggedOut;

    return result.isRight();
  }
}
