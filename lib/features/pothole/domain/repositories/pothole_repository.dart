import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:fpdart/fpdart.dart';

abstract class PotholeRepository {
  Future<Either<Failure, Pothole>> getPotholeById(String potholeId);
  Future<Either<Failure, Pothole>> savePotholeById(String potholeId, Map<String, dynamic> potholeLike);
}