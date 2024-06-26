import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLogin extends Mock implements Login {}

class MockSessionController extends GetxService
    with Mock
    implements SessionController {}

void main() {
  late MockSessionController mockSessionController;
  late MockLogin mockLogin;
  late LoginController controller;

  setUp(() {
    mockSessionController = MockSessionController();

    Get.put<SessionController>(mockSessionController);
    
    mockLogin = MockLogin();
    controller = LoginController(
      loginUseCase: mockLogin,
    );
  });

  const email = 'LpJp4@example.com';
  const password = 'password123';

  final session = Session(token: 'token123');

  group('LoginController', () {
    test('initial value are correct', () {
      expect(controller.isLoading, isTrue);
    });

    test('login sets user correctly when succeeds', () async {
      // arrange
      when(() => mockLogin.call(email, password))
          .thenAnswer((_) async => Right(session));
      when(() => mockSessionController.status)
          .thenReturn(Rx<SessionStatus>(SessionStatus.checking));
      when(() => mockSessionController.session).thenReturn(Rxn<Session>(null));
      // act
      final result = controller.login(email, password);
      expect(controller.isLoading, isTrue);
      final resolvedResult = await result;
      // assert
      expect(controller.isLoading, isFalse);
      expect(resolvedResult, true);
      verify(() => mockLogin.call(email, password)).called(1);
      verifyNoMoreInteractions(mockLogin);
    });

    test('login handles failure correctly', () async {
      // arrange
      when(() => mockLogin.call(any<String>(), any<String>()))
          .thenAnswer((_) async => Left(Exception('Invalid credentials')));
      when(() => mockSessionController.status)
          .thenReturn(Rx<SessionStatus>(SessionStatus.checking));
      when(() => mockSessionController.session).thenReturn(Rxn<Session>(null));
      // act
      final result = controller.login(email, password);
      expect(controller.isLoading, isTrue);
      final resolvedResult = await result;
      // assert
      expect(controller.isLoading, isFalse);
      expect(resolvedResult, false);
      verify(() => mockLogin.call(email, password)).called(1);
      verifyNoMoreInteractions(mockLogin);
    });

    tearDown(() {
      Get.reset();
    });
  });
}
