import 'package:bache_finder_app/core/errors/api_data_exception.dart';
import 'package:bache_finder_app/core/errors/failures/api_data_failure.dart';
import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/core/errors/failures/network_failure.dart';
import 'package:bache_finder_app/core/errors/failures/unknown_failure.dart';
import 'package:bache_finder_app/core/errors/network_exception.dart';
import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bache_finder_app/features/auth/infraestructure/data_sources/auth_local_data_source.dart';
import 'package:bache_finder_app/features/auth/infraestructure/data_sources/auth_remote_data_source.dart';
import 'package:bache_finder_app/features/auth/infraestructure/errors/failures/token_not_found_failure.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, Session>> login(String email, password) async {
    try {
      final response = await authRemoteDataSource.login(email, password);
      await authLocalDataSource.setToken(response.token);
      return Right(response);
    } on ApiDataException catch (e) {
      return Left(ApiDataFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final token = await authLocalDataSource.getToken();
      if (token == null) {
        return const Left(TokenNotFoundFailure('Token no encontrado'));
      }
      final response = await authRemoteDataSource.logout(token);
      await authLocalDataSource.deleteToken();
      return Right(response);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> register(Map<String, dynamic> registerLike) async {
    try {
      final response = await authRemoteDataSource.register(registerLike);
      return Right(response);
    } on ApiDataException catch (e) {
      return Left(ApiDataFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Session>> validateSession() async {
    try {
      final token = await authLocalDataSource.getToken();
      if (token == null) {
        return const Left(TokenNotFoundFailure('Token no encontrado'));
      }
      await authRemoteDataSource.fetchUserData(token);
      return Right(Session(token: token));
    } on ApiDataException catch (e) {
      return Left(ApiDataFailure(e.toString()));   
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
