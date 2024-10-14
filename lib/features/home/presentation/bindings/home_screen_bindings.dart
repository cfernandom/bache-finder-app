import 'package:bache_finder_app/features/user/application/services/user_services.dart';
import 'package:bache_finder_app/features/user/application/use_cases/get_current_user.dart';
import 'package:bache_finder_app/features/user/infraestructure/data_sources/user_data_source.dart';
import 'package:bache_finder_app/features/user/presentation/controllers/user_controller.dart';
import 'package:get/get.dart';

class HomeScreenBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController(
        getCurrentUser: GetCurrentUser(UserServices(UserDataSource()))));
  }
  
  void removeDependencies() {
    Get.delete<UserController>();
  }
}