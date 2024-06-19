import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class Logout {
  final AuthRepository authRepository;

  Logout(this.authRepository);

  Future<Either<Exception, void>> call() {
    return authRepository.logout();
  }
}