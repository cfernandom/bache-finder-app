import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/auth_controller.dart';

class MockLogin extends Mock implements Login {}

class MockLogout extends Mock implements Logout {}

void main() {
  late MockLogin mockLogin;
  late MockLogout mockLogout;

  late AuthController controller;

  setUp(() {
    mockLogin = MockLogin();
    mockLogout = MockLogout();
    controller = AuthController(
      loginUseCase: mockLogin,
      logoutUseCase: mockLogout,
    );
  });

  const email = 'LpJp4@example.com';
  const password = 'password123';
  
  final session = Session(token: 'token123');

  group('AuthController', () {
    test('initial value are correct', () {
      expect(controller.isLoading.value, isTrue);
    });

    test('login sets user correctly when succeeds', () async {
      // arrange
      when(() => mockLogin.call(any<String>(), any<String>()))
          .thenAnswer((_) async => Right(session));
      // act
      final result = controller.login(email, password);
      expect(controller.isLoading.value, isTrue);
      final resultValue = await result;
      // assert
      expect(resultValue, isTrue);
      expect(controller.isLoading.value, isFalse);
      verify(() => mockLogin.call(email, password)).called(1);
      verifyNoMoreInteractions(mockLogin);
    });

    test('login handles failure correctly', () async {
      // arrange
      when(() => mockLogin.call(any<String>(), any<String>()))
          .thenAnswer((_) async => Left(Exception('Invalid credentials')));
      // act
      final result = controller.login(email, password);
      expect(controller.isLoading.value, isTrue);
      final resultValue = await result;
      // assert
      expect(resultValue, isFalse);
      expect(controller.isLoading.value, isFalse);
      verify(() => mockLogin.call(email, password)).called(1);
      verifyNoMoreInteractions(mockLogin);
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
      verify(() => mockLogout.call()).called(1);
      verifyNoMoreInteractions(mockLogout);
    });
  });

  tearDown(() {
    Get.reset();
  });
}
