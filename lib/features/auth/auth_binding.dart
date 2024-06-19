import 'package:bache_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/login.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/logout.dart';
import 'package:bache_finder_app/features/auth/domain/use_cases/validate_session.dart';
import 'package:bache_finder_app/features/auth/infraestructure/auth_data_source.dart';
import 'package:bache_finder_app/features/auth/infraestructure/auth_repository_impl.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthDataSource(
          dio: Get.find(),
          storageService: Get.find(),
        ));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(authDataSource: Get.find()));
    Get.lazyPut(() => Login(Get.find()));
    Get.lazyPut(() => Logout(Get.find()));
    Get.lazyPut(() => ValidateSession(Get.find()));
    Get.lazyPut(() => AuthController(
          loginUseCase: Get.find(),
          logoutUseCase: Get.find(),
          validateSessionUseCase: Get.find(),
        ));
  }
}
