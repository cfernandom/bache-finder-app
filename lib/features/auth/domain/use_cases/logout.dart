import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

class Logout {
  final AuthRepository authRepository;

  Logout(this.authRepository);

  Future<Either<Failure, void>> call() {
    return authRepository.logout();
  }
}