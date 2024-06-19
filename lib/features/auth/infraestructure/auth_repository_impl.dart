import 'package:bache_finder_app/features/auth/domain/entities/user.dart';
import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bache_finder_app/features/auth/infraestructure/auth_data_source.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Exception, User>> login(String email, password) async {
    try {
      final response = await authDataSource.login(email, password);
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> logout() async {
    try {
      final response = await authDataSource.logout();
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, User?>> validateSession() async {
    try {
      final response = await authDataSource.validateSession();
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
