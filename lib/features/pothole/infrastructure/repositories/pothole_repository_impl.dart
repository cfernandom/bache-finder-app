import 'package:bache_finder_app/core/errors/api_data_exception.dart';
import 'package:bache_finder_app/core/errors/failures/api_data_failure.dart';
import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/core/errors/failures/network_failure.dart';
import 'package:bache_finder_app/core/errors/failures/unknown_failure.dart';
import 'package:bache_finder_app/core/errors/network_exception.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole_prediction.dart';
import 'package:bache_finder_app/features/pothole/domain/repositories/pothole_repository.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/data_sources/pothole_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

class PotholeRepositoryImpl implements PotholeRepository {
  final PotholeRemoteDataSource potholeRemoteDataSource;

  PotholeRepositoryImpl({required this.potholeRemoteDataSource});

  @override
  Future<Either<Failure, Pothole>> getPotholeById(String potholeId) async {
    try {
      final pothole = await potholeRemoteDataSource.fetchPotholeById(potholeId);
      return Right(pothole);
    } on ApiDataException catch (e) {
      return Left(ApiDataFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Pothole>> savePotholeById(String potholeId, Map<String, dynamic> potholeLike) async {
    try {
      final pothole = await potholeRemoteDataSource.savePotholeById(potholeId, potholeLike);
      return Right(pothole);
    } on ApiDataException catch (e) {
      return Left(ApiDataFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Pothole>>> getPotholes(int page) async {
    try {
      final potholes = await potholeRemoteDataSource.getPotholes(page);
      return Right(potholes);
    } on ApiDataException catch (e) {
      return Left(ApiDataFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PotholePrediction>> predictPotholeById(String potholeId) async {
    try {
      final predictions = await potholeRemoteDataSource.predictPothole(potholeId);
      return Right(predictions);
    } on ApiDataException catch (e) {
      return Left(ApiDataFailure(e.toString()));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.toString()));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
