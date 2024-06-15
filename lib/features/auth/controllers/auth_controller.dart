import 'package:bache_finder_app/features/shared/services/storage_service_impl.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _isAuth = false.obs; // always false at first
  final _isAuthLoading = true.obs; // always true at first
  final storageService = StorageServiceImpl();

  RxBool get isAuth => _isAuth;
  RxBool get isAuthLoading => _isAuthLoading;

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }

  void checkAuth() async {    
    final isValidSession = await verifySession();
    
    if (!isValidSession) {
      setUnAuth();
      Get.offAllNamed('/login');
      return;
    }
    setAuth();
    Get.offAllNamed('/');
  }

  Future<bool> verifySession() async {
    final String? token = await storageService.getValueByKey('token');
    
    if (token != null) {
      return await _verifyToken(token);
    }

    return false;
  }

  Future<bool> _verifyToken(String token) async {
    // TODO: Verify token
    // simulate checking auth
    await Future.delayed(const Duration(seconds: 1), () {
    });
    return true;
  }

  Future<void> login(String token) async {
    await storageService.setKeyValue('token', token);
    setAuth();
  }

  Future<void> logout() async {
    await storageService.deleteValueByKey('token');
    setUnAuth();
  }

  setAuth() {
    _isAuth.value = true;
    _isAuthLoading.value = false;
  }

  setUnAuth() {
    _isAuth.value = false;
    _isAuthLoading.value = false;
  }
}
