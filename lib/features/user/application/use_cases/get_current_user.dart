import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/auth/domain/entities/user.dart';
import 'package:bache_finder_app/features/user/domain/repositories/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser {
  final UserRepository userRepository;

  GetCurrentUser(this.userRepository);

  Future<Either<Failure, User>> call() async {
    return await userRepository.getCurrentUser();
  }
}