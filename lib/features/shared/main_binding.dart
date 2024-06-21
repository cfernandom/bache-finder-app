import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/validate_session.dart';
import 'package:bache_finder_app/features/auth/infraestructure/data_sources/auth_local_data_source.dart';
import 'package:bache_finder_app/features/auth/infraestructure/data_sources/auth_remote_data_source.dart';
import 'package:bache_finder_app/features/auth/infraestructure/repositories/auth_repository_impl.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/shared/services/storage_service.dart';
import 'package:bache_finder_app/features/shared/services/storage_service_impl.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Dio(), permanent: true);
    Get.put<StorageService>(StorageServiceImpl(), permanent: true);
    Get.put(AuthRemoteDataSource(dio: Get.find()));
    Get.put(AuthLocalDataSource(storageService: Get.find()));
    Get.put<AuthRepository>(AuthRepositoryImpl(
      authRemoteDataSource: Get.find(),
      authLocalDataSource: Get.find(),
    ));
    Get.put(ValidateSession(Get.find()));
    Get.put(SessionController(validateSessionUseCase: Get.find()),
        permanent: true);
  }
}
