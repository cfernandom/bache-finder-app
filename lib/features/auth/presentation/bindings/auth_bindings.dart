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

class AuthBindings extends Bindings {
  @override
  void dependencies() async {
    final authRepository = Get.put<AuthRepository>(
      AuthRepositoryImpl(
        authLocalDataSource: Get.put<AuthLocalDataSource>(
          AuthLocalDataSource(
            storageService: Get.put<StorageService>(
              StorageServiceImpl(),
            ),
          ),
        ),
        authRemoteDataSource: Get.put<AuthRemoteDataSource>(
          AuthRemoteDataSource(),
        ),
      ),
    );

    Get.put<SessionController>(
      SessionController(
        validateSessionUseCase: Get.put(ValidateSession(authRepository)),
        loginUseCase: Get.put(Login(authRepository)),
        logoutUseCase: Get.put(Logout(authRepository)),
      ),
    );
  }
}
