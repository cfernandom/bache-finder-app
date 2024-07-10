import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/pothole/domain/repositories/pothole_repository.dart';
import 'package:bache_finder_app/features/pothole/domain/use_cases/get_potholes.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/data_sources/pothole_remote_data_source.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/repositories/pothole_repository_impl.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/potholes_controller.dart';
import 'package:get/get.dart';

class PotholesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => PotholeRemoteDataSource(
        accessToken: Get.find<SessionController>().session?.token ?? '',
      ),
    );

    Get.lazyPut<PotholeRepository>(
      () => PotholeRepositoryImpl(
        potholeRemoteDataSource: Get.find<PotholeRemoteDataSource>(),
      ),
    );
    
    Get.lazyPut(
      () => GetPotholes(
        Get.find<PotholeRepository>(),
      ),
    );

    Get.lazyPut(
      () => PotholesController(getPotholesUseCase: Get.find<GetPotholes>()),
    );
  }
}
