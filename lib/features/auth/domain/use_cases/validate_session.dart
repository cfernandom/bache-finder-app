import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ValidateSession {
  final AuthRepository authRepository;

  ValidateSession(this.authRepository);
  
  Future<Either<Exception, Session>> call() {
    return authRepository.validateSession();
  }
}
