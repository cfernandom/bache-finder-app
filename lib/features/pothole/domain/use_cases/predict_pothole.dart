import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole_prediction.dart';
import 'package:bache_finder_app/features/pothole/domain/repositories/pothole_repository.dart';
import 'package:fpdart/fpdart.dart';

class PredictPothole {
  final PotholeRepository potholeRepository;

  PredictPothole(this.potholeRepository);

  Future<Either<Failure, PotholePrediction>> call(String potholeId) {
    return potholeRepository.predictPotholeById(potholeId);
  }
}
