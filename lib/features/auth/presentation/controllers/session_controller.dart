import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/validate_session.dart';
import 'package:get/get.dart';

enum SessionStatus {
  loggedOut,
  loggedIn,
  checking,
}

class SessionController extends GetxController {
  final ValidateSession _validateSessionUseCase;
  final Login _loginUseCase;
  final Logout _logoutUseCase;

  SessionController({
    required ValidateSession validateSessionUseCase,
    required Login loginUseCase,
    required Logout logoutUseCase,
  })  : _validateSessionUseCase = validateSessionUseCase,
        _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase;

  final _session = Rxn<Session>();
  final _status = SessionStatus.checking.obs;
  final _isLoading = true.obs;
  final _errorMessage = Rxn<String>();

  Session? get session => _session.value;
  Rx<SessionStatus> get status => _status;
  Rx<bool> get isLoading => _isLoading;
  String get errorMessage => _errorMessage.value ?? '';

  void resetErrorMessage() => _errorMessage.value = '';

  @override
  void onInit() {
    super.onInit();
    validateSession();
  }

  Future<bool> validateSession() async {
    final result = await _validateSessionUseCase.call();
    result.fold(
      (failure) => _errorMessage.value = failure.message,
      (session) => _session.value = session,
    );

    _status.value =
        result.isRight() ? SessionStatus.loggedIn : SessionStatus.loggedOut;

    return result.isRight();
  }

  Future<bool> login(String email, String password) async {
    _isLoading.value = true;
    final result = await _loginUseCase.call(email, password);

    result.fold(
      (failure) => _errorMessage.value = failure.message,
      (session) => _session.value = session,
    );

    _status.value =
        result.isRight() ? SessionStatus.loggedIn : SessionStatus.loggedOut;

    _isLoading.value = false;
    return result.isRight();
  }

  Future<void> logout() async {
    _isLoading.value = true;
    final result = await _logoutUseCase.call();

    result.fold(
      (failure) => _errorMessage.value = failure.message,
      (_) => () {},
    );

    _session.value = null;
    _status.value = SessionStatus.loggedOut;
    _isLoading.value = false;
  }
}
