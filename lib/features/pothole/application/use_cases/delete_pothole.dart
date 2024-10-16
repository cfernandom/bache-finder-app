import 'package:bache_finder_app/core/errors/failures/failure.dart';
import 'package:bache_finder_app/features/pothole/domain/repositories/pothole_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeletePothole {
  final PotholeRepository potholeRepository;

  DeletePothole(
    this.potholeRepository,
  );

  Future<Either<Failure, void>> call(String potholeId) {
    return potholeRepository.deletePothole(potholeId);
  }
}
