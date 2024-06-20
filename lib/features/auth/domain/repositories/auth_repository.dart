import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Exception, Session>> login(String email, String password);
  Future<Either<Exception, void>> logout();
  Future<Either<Exception, User>> validateSession();
}