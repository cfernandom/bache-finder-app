import 'package:bache_finder_app/features/auth/domain/entities/user.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/mappers/user_mapper.dart';
import 'package:bache_finder_app/features/shared/infrastructure/http/dio_client.dart';
import 'package:dio/dio.dart';

class UserDataSource {
  final Dio _dio;

  UserDataSource() : _dio = DioClient.getInstance().dio;

  Future<User> getCurrentUser() async {
    final response = await _dio.get('v1/user');
    return UserMapper.fromJson(response.data['data']);
  }
}
