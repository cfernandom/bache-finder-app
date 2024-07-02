import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/infraestructure/models/session_model.dart';
import 'package:bache_finder_app/features/auth/infraestructure/models/user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({
    required this.dio,
  }) {
    dio.options.baseUrl = Enviroment.bacheFinderApiUrl();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Accept'] = 'application/json';
  }

  Future<Session> login(String email, String password) async {
    try {
      final response = await dio.post(
        'v1/login',
        data: {'email': email, 'password': password},
      );
      return SessionModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> fetchUserData(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get('v1/user');
      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.post('v1/logout');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message']);
    } catch (e) {
      throw Exception(e);
    }
  }
}
