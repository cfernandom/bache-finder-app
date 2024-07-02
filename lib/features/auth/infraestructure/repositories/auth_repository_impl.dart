import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bache_finder_app/features/auth/infraestructure/data_sources/auth_local_data_source.dart';
import 'package:bache_finder_app/features/auth/infraestructure/data_sources/auth_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Exception, Session>> login(String email, password) async {
    try {
      final response = await authRemoteDataSource.login(email, password);
      await authLocalDataSource.setToken(response.token);
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> logout() async {
    try {
      final token = await authLocalDataSource.getToken();
      if (token == null) {
        return Left(Exception('No token found'));
      }
      final response = await authRemoteDataSource.logout(token);
      await authLocalDataSource.deleteToken();
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Session>> validateSession() async {
    try {
      final token = await authLocalDataSource.getToken();
      if (token == null) {
        return Left(Exception('No token found'));
      }
      await authRemoteDataSource.requestUserData(token);
      return Right(Session(token: token));
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
