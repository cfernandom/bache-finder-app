import 'package:bache_finder_app/features/pothole/domain/repositories/pothole_repository.dart';
import 'package:bache_finder_app/features/pothole/domain/use_cases/get_pothole.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/forms/pothole_form_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/pothole_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/potholes_controller.dart';
import 'package:get/get.dart';

class PotholeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(
    //   () => PotholeRemoteDataSource(
    //     accessToken: Get.find<SessionController>().session?.token ?? '',
    //   ),
    // );

    // Get.lazyPut<PotholeRepository>(
    //   () => PotholeRepositoryImpl(
    //     potholeRemoteDataSource: Get.find<PotholeRemoteDataSource>(),
    //   ),
    // );

    Get.lazyPut(
      () => GetPothole(
        Get.find<PotholeRepository>(),
      ),
    );

    Get.lazyPut(
      () => PotholeController(
        Get.arguments['id'],
        getPotholeUseCase: Get.find<GetPothole>(),
        savePotholeCallback: Get.find<PotholesController>().savePothole,
      ),
    );

    Get.lazyPut(
      () => PotholeFormController(
        Get.find<PotholeController>().pothole.value,
        onSubmitCallback: Get.find<PotholeController>().savePothole,
      ),
    );
  }
}
