import 'package:bache_finder_app/core/router/app_router_controller.dart';
import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/validate_session.dart';
import 'package:bache_finder_app/features/auth/infraestructure/data_sources/auth_local_data_source.dart';
import 'package:bache_finder_app/features/auth/infraestructure/data_sources/auth_remote_data_source.dart';
import 'package:bache_finder_app/features/auth/infraestructure/repositories/auth_repository_impl.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:bache_finder_app/features/shared/services/storage_service.dart';
import 'package:bache_finder_app/features/shared/services/storage_service_impl.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() async {}

  static setupDependencies() async {
    Get.put<StorageService>(
      StorageServiceImpl(),
    );

    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSource(),
    );

    Get.put<AuthLocalDataSource>(
      AuthLocalDataSource(storageService: Get.find()),
    );

    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        authRemoteDataSource: Get.find(),
        authLocalDataSource: Get.find(),
      ),
    );

    Get.put<ValidateSession>(
      ValidateSession(Get.find()),
    );

    Get.put<Login>(
      Login(Get.find()),
    );

    Get.put<Logout>(
      Logout(Get.find()),
    );

    Get.put<SessionController>(
      SessionController(
        validateSessionUseCase: Get.find(),
        loginUseCase: Get.find(),
        logoutUseCase: Get.find(),
      ),
      permanent: true,
    );

    await Get.find<SessionController>().validateSession();

    Get.put<AppRouterController>(
      AppRouterController(sessionController: Get.find()),
      permanent: true,
    );
  }
}
