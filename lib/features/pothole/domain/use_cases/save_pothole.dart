import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/repositories/pothole_repository.dart';
import 'package:fpdart/fpdart.dart';

class SavePothole {
  final PotholeRepository potholeRepository;

  SavePothole(this.potholeRepository);

  Future<Either<Failure, Pothole>> call(
      String potholeId, Map<String, dynamic> potholeLike) {
    return potholeRepository.savePotholeById(potholeId, potholeLike);
  }
}
