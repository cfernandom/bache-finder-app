import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/features/auth/infraestructure/models/user_model.dart';
import 'package:bache_finder_app/features/shared/services/storage_service.dart';
import 'package:dio/dio.dart';

class AuthDataSource {
  final Dio dio;
  final StorageService storageService;

  AuthDataSource({
    required this.dio,
    required this.storageService,
  }) {
    dio.options.baseUrl = Enviroment.bacheFinderApiUrl();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
  }

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        'v1/login',
        data: {'email': email, 'password': password},
      );
      await _setLocalToken(response.data['data']['token']);

      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getUserData() async {
    try {
      final token = await _getLocalToken();
      if (token == null) {
        throw Exception('No token found');
      }
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get('v1/user');
      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    try {
      final token = await _getLocalToken();
      if (token == null) {
        return;
      }
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.post('v1/logout');
      _deleteLocalToken();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> _getLocalToken() async {
    return await storageService.getValueByKey('token');
  }

  Future<void> _deleteLocalToken() async {
    await storageService.deleteValueByKey('token');
  }

  Future<void> _setLocalToken(String token) async {
    await storageService.setKeyValue('token', token);
  }
}
