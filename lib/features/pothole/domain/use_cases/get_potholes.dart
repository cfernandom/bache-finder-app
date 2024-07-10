import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/repositories/pothole_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetPotholes {
  final PotholeRepository potholeRepository;

  GetPotholes(this.potholeRepository);

  Future<Either<Failure, List<Pothole>>> call(int page) {
    return potholeRepository.getPotholes(page);
  }
}