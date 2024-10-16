import 'package:bache_finder_app/features/pothole/domain/repositories/pothole_repository.dart';
import 'package:bache_finder_app/features/pothole/application/use_cases/get_pothole.dart';
import 'package:bache_finder_app/features/pothole/application/use_cases/predict_pothole.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/forms/pothole_form_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/pothole_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/controllers/potholes_controller.dart';
import 'package:bache_finder_app/features/pothole/presentation/widgets/location_picker_widget.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';

class PotholeBinding extends Bindings {
  final String potholeId;

  PotholeBinding({required this.potholeId});

  @override
  void dependencies() async {
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
      () => PredictPothole(
        Get.find<PotholeRepository>(),
      ),
    );

    Get.lazyPut(
      () => PotholeController(
        potholeId,
        getPotholeUseCase: Get.find<GetPothole>(),
        predictPotholeUseCase: Get.find<PredictPothole>(),
        savePotholeCallback: Get.find<PotholesController>().savePothole,
        deletePotholeCallback: Get.find<PotholesController>().deletePothole,
      ),
    );

    Get.lazyPut(
      () => PotholeFormController(
        Get.find<PotholeController>().pothole.value,
        onSubmitCallback: Get.find<PotholeController>().savePothole,
        onPredictCallback: Get.find<PotholeController>().predictPothole,
      ),
    );

    Get.delete<LocationPickerController>();
    Get.lazyPut(() {
      final potholeFormController = Get.find<PotholeFormController>();
      final currentLat =
          double.tryParse(potholeFormController.latitude.value.value);
      final currentLng =
          double.tryParse(potholeFormController.longitude.value.value);
      final currentLatLng = currentLat != null && currentLng != null
          ? LatLng(currentLat, currentLng)
          : null;
      return LocationPickerController(
        currentLatLng: currentLatLng,
        onLocationChangedCallback: potholeFormController.onLocationChanged,
      );
    });
  }

  void removeDependencies() {
    Get.delete<PotholeFormController>();
    Get.delete<PotholeController>();
    Get.delete<GetPothole>();
    Get.delete<PredictPothole>();
  }
}
