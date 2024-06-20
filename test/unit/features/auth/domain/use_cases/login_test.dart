import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late Login login;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    login = Login(mockAuthRepository);
  });

  const email = 'LpJp4@example.com';
  const password = 'password123';
  final session = Session(token: 'token123');

  test('should return a user when login is successful', () async {
    // arrange
    when(() => mockAuthRepository.login(
            any<String>(), any<String>()))
        .thenAnswer((_) async => Right(session));

    // act
    final result = await login.call(email, password);

    // assert
    expect(result, Right(session));
    verify(() => mockAuthRepository.login(email, password)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return an exception when login fails', () async {
    // arrange
    when(() => mockAuthRepository.login(any<String>(), any<String>()))
        .thenAnswer((_) async => Left(Exception("Invalid credentials")));

    // act
    final result = await login.call(email, password);

    // assert
    expect(result, isA<Left>());
    verify(() => mockAuthRepository.login(email, password)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
