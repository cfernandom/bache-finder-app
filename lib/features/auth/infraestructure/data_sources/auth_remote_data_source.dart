import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/core/errors/api_data_exception.dart';
import 'package:bache_finder_app/core/errors/dio_error_handler.dart';
import 'package:bache_finder_app/core/errors/network_exception.dart';
import 'package:bache_finder_app/features/auth/domain/entities/session.dart';
import 'package:bache_finder_app/features/auth/infraestructure/models/session_model.dart';
import 'package:bache_finder_app/features/auth/infraestructure/models/user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  late final Dio _dio;

  AuthRemoteDataSource(
  ) : _dio = Dio() {
    _dio.options.baseUrl = Enviroment.bacheFinderApiUrl();
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
  }

  Future<Session> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'v1/login',
        data: {'email': email, 'password': password},
      );
      if (response.data['data'] == null) {
        throw ApiDataException('Error al recuperar datos. No se encontraron datos de autenticación.');
      }
      return SessionModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      final errorMessage = DioErrorHandler.getErrorMessage(e);
      throw NetworkException(errorMessage);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> fetchUserData(String token) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await _dio.get('v1/user');
      if (response.data['data'] == null) {
        throw ApiDataException('Error al recuperar datos. No se encontraron datos de usuario.');
      }
      return UserModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      final errorMessage = DioErrorHandler.getErrorMessage(e);
      throw NetworkException('Error al recuperar datos: $errorMessage');
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logout(String token) async {
    try {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      await _dio.post('v1/logout');
    } on DioException catch (e) {
      final errorMessage = DioErrorHandler.getErrorMessage(e);
      throw NetworkException(errorMessage);
    } catch (e) {
      throw Exception(e);
    }
  }
}
