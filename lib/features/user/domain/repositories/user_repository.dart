import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/auth/domain/entities/user.dart';
import 'package:bache_finder_app/features/shared/domain/repository/base_repository.dart';
import 'package:fpdart/fpdart.dart';

abstract class UserRepository extends BaseRepository<User, String> {
  Future<Either<Failure, User>> getCurrentUser();
}
