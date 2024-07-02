import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/validate_session.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class MockValidateSession extends Mock implements ValidateSession {}

class MockLogin extends Mock implements Login {}

class MockLogout extends Mock implements Logout {}

void main() {
  late MockValidateSession mockValidateSession;
  late MockLogin mockLogin;
  late MockLogout mockLogout;

  late SessionController controller;

  setUp(() {
    mockValidateSession = MockValidateSession();
    mockLogin = MockLogin();
    mockLogout = MockLogout();

    controller = SessionController(
      validateSessionUseCase: mockValidateSession,
      loginUseCase: mockLogin,
      logoutUseCase: mockLogout,
    );
  });

  final session = Session(
    token: 'token123',
  );

  group('SessionController', () {
    test('initial value are correct', () {
      expect(controller.isLoading.value, isTrue);
    });

    test('validateSession sets user correctly when succeeds', () async {
      // arrange
      when(() => mockValidateSession.call())
          .thenAnswer((_) async => Right(session));
      // act
      final result = await controller.validateSession();
      // assert
      expect(result, isTrue);
      expect(controller.session, session);
      expect(controller.status, Rx(SessionStatus.loggedIn));
      verify(() => mockValidateSession.call()).called(1);
      verifyNoMoreInteractions(mockValidateSession);
    });

    test('validateSession handles failure correctly', () async {
      // arrange
      when(() => mockValidateSession.call())
          .thenAnswer((_) async => Left(Exception('Session invalid')));
      // act
      final result = controller.validateSession();
      expect(controller.status, Rx(SessionStatus.checking));
      final resultValue = await result;
      // assert
      expect(resultValue, isFalse);
      expect(controller.session, isNull);
      expect(controller.status, Rx(SessionStatus.loggedOut));
      verify(() => mockValidateSession.call()).called(1);
      verifyNoMoreInteractions(mockValidateSession);
    });

    test('logout sets user correctly when succeeds', () async {
      // arrange
      when(() => mockLogout.call()).thenAnswer((_) async => const Right(null));
      // act
      final result = controller.logout();
      expect(controller.isLoading.value, isTrue);
      await result;
      // assert
      expect(controller.isLoading.value, isFalse);
      expect(controller.session, null);
      expect(controller.status, Rx(SessionStatus.loggedOut));
      verify(() => mockLogout.call()).called(1);
      verifyNoMoreInteractions(mockLogout);
    });

    test('login sets user correctly when succeeds', () async {
      // arrange
      when(() => mockLogin.call(any<String>(), any<String>()))
          .thenAnswer((_) async => Right(session));
      // act
      final result = controller.login('email', 'password');
      expect(controller.isLoading.value, isTrue);
      await result;
      // assert
      expect(controller.isLoading.value, isFalse);
      expect(controller.session, session);
      expect(controller.status, Rx(SessionStatus.loggedIn));
      verify(() => mockLogin.call(any<String>(), any<String>())).called(1);
      verifyNoMoreInteractions(mockLogin);
    });

    test('login handles failure correctly', () async {
      // arrange
      when(() => mockLogin.call(any<String>(), any<String>()))
          .thenAnswer((_) async => Left(Exception('Invalid credentials')));
      // act
      final result = controller.login('email', 'password');
      expect(controller.isLoading.value, isTrue);
      await result;
      // assert
      expect(controller.isLoading.value, isFalse);
      expect(controller.session, null);
      expect(controller.status, Rx(SessionStatus.loggedOut));
      verify(() => mockLogin.call(any<String>(), any<String>())).called(1);
      verifyNoMoreInteractions(mockLogin);
    });

    tearDown(() {
      Get.reset();
    });
  });
}
