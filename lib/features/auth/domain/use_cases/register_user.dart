import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUser {
  RegisterUser(this.authRepository);

  final AuthRepository authRepository;

  Future<Either<Failure, bool>> call(Map<String, dynamic> registerLike) {
    return authRepository.register(registerLike);
  }
}
