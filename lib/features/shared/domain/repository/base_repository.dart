import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class BaseRepository<T, ID> {
  Future<Either<Failure, T>> get(ID id);
  Future<Either<Failure, T>> save(T pothole);
  Future<Either<Failure, T>> delete(ID id);
  Future<Either<Failure, List<T>>> getList(int page);
}