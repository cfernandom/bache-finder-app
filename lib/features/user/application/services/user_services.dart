import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/core/errors/failures/unknown_failure.dart';
import 'package:bache_finder_app/features/auth/domain/entities/user.dart';
import 'package:bache_finder_app/features/user/domain/repositories/user_repository.dart';
import 'package:bache_finder_app/features/user/infraestructure/data_sources/user_data_source.dart';
import 'package:fpdart/fpdart.dart';

class UserServices implements UserRepository {
  final UserDataSource _dataSource;

  UserServices(this._dataSource);

  @override
  Future<Either<Failure, User>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await _dataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getList(int page) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> save(User pothole) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
