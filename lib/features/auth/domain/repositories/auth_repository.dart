import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, Session>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, Session>> validateSession();
}