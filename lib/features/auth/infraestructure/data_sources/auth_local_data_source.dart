import 'package:bache_finder_app/features/shared/services/storage_service.dart';

class AuthLocalDataSource {
  final StorageService storageService;

  AuthLocalDataSource({required this.storageService});

  Future<String?> getToken() async {
    return await storageService.getValueByKey('token');
  }

  Future<void> deleteToken() async {
    await storageService.deleteValueByKey('token');
  }

  Future<void> setToken(String token) async {
    await storageService.setKeyValue('token', token);
  }
}
