import 'package:bache_finder_app/features/auth/domain/entities/user.dart';
import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bache_finder_app/features/auth/infraestructure/auth_data_source.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Exception, User>> login(String email, password) async {
    try {
      final response = await authRemoteDataSource.login(email, password);
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> logout() async {
    try {
      final response = await authRemoteDataSource.logout();
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, User>> validateSession() async {
    try {
      final response = await authRemoteDataSource.getUserData();
      return Right(response);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
