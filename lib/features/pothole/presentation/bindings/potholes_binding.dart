import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/pothole/application/use_cases/delete_pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/repositories/pothole_repository.dart';
import 'package:bache_finder_app/features/pothole/application/use_cases/get_potholes.dart';
import 'package:bache_finder_app/features/pothole/application/use_cases/save_pothole.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/data_sources/pothole_remote_data_source.dart';
import 'package:bache_finder_app/features/pothole/application/services/pothole_services.dart';
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
      () => PotholeSevices(
        potholeRemoteDataSource: Get.find<PotholeRemoteDataSource>(),
      ),
    );

    Get.lazyPut(
      () => GetPotholes(
        Get.find<PotholeRepository>(),
      ),
    );

    Get.lazyPut(
      () => SavePothole(
        Get.find<PotholeRepository>(),
      ),
    );

    Get.lazyPut(
      () => DeletePothole(
        Get.find<PotholeRepository>(),
      ),
    );

    Get.lazyPut(
      () => PotholesController(
        getPotholesUseCase: Get.find<GetPotholes>(),
        savePotholeUseCase: Get.find<SavePothole>(),
        deletePothole: Get.find<DeletePothole>(),
      ),
    );
  }

  void removeDependencies() {
    Get.delete<PotholesController>();
    Get.delete<GetPotholes>();
    Get.delete<SavePothole>();
    Get.delete<PotholeRepository>();
    Get.delete<PotholeRemoteDataSource>();
  }
}
