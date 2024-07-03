import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

class Login {
  final AuthRepository authRepository;

  Login(this.authRepository);

  Future<Either<Failure, Session>> call(String email, String password) {
    return authRepository.login(email, password);
  }
}
