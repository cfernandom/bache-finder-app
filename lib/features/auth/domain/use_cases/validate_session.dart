import 'package:bache_finder_app/features/auth/domain/entities/user.dart';
import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ValidateSession {
  final AuthRepository authRepository;

  ValidateSession(this.authRepository);
  
  Future<Either<Exception, User?>> call() {
    return authRepository.validateSession();
  }
}
