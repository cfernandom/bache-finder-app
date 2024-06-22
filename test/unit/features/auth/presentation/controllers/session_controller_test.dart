import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/validate_session.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockValidateSession extends Mock implements ValidateSession {}

void main() {
  late MockValidateSession mockValidateSession;
  late SessionController controller;

  setUp(() {
    mockValidateSession = MockValidateSession();
    controller = SessionController(validateSessionUseCase: mockValidateSession);
  });

  final session = Session(
    token: 'token123',
  );

  group('SessionController', () {
      test('validateSession sets user correctly when succeeds', () async {
      // arrange
      when(() => mockValidateSession.call())
          .thenAnswer((_) async => Right(session));
      // act
      final result = await controller.validateSession();
      // assert
      expect(result, isTrue);
      expect(controller.session.value, session);
      expect(controller.status.value, SessionStatus.loggedIn);
      verify(() => mockValidateSession.call()).called(1);
      verifyNoMoreInteractions(mockValidateSession);
    });

    test('validateSession handles failure correctly', () async {
      // arrange
      when(() => mockValidateSession.call())
          .thenAnswer((_) async => Left(Exception('Session invalid')));
      // act
      final result = controller.validateSession();
      expect(controller.status.value, SessionStatus.checking);
      final resultValue = await result;
      // assert
      expect(resultValue, isFalse);
      expect(controller.session.value, isNull);
      expect(controller.status.value, SessionStatus.loggedOut);
      verify(() => mockValidateSession.call()).called(1);
      verifyNoMoreInteractions(mockValidateSession);
    });
  });
}
