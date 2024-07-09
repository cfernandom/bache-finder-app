import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/pothole/domain/repositories/pothole_repository.dart';
import 'package:bache_finder_app/features/pothole/domain/use_cases/get_pothole.dart';
import 'package:bache_finder_app/features/pothole/domain/use_cases/save_pothole.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/data_sources/pothole_remote_data_source.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/repositories/pothole_repository_impl.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/forms/pothole_form_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/pothole_controller.dart';
import 'package:get/get.dart';

class PotholeBinding extends Bindings {
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
      () => GetPothole(
        Get.find<PotholeRepository>(),
      ),
    );

    Get.lazyPut(
      () => SavePothole(
        Get.find<PotholeRepository>(),
      ),
    );

    Get.lazyPut(
      () => PotholeController(
        Get.arguments['id'],
        getPotholeUseCase: Get.find<GetPothole>(),
        savePotholeUseCase: Get.find<SavePothole>(),
      ),
    );

    Get.lazyPut(() => PotholeFormController(Get.arguments['id'],
        onSubmitCallback: Get.find<PotholeController>().savePothole));
  }
}
