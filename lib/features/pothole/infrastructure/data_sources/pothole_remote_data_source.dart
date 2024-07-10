import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/core/errors/api_data_exception.dart';
import 'package:bache_finder_app/core/errors/dio_error_handler.dart';
import 'package:bache_finder_app/core/errors/network_exception.dart';
import 'package:bache_finder_app/features/pothole/infrastructure/models/pothole_model.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';

class PotholeRemoteDataSource {
  late final Dio _dio;
  final String accessToken;

  PotholeRemoteDataSource({required this.accessToken}) : _dio = Dio() {
    _dio.options.baseUrl = Enviroment.bacheFinderApiUrl();
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
  }

  Future<PotholeModel> fetchPotholeById(String potholeId) async {
    try {
      final response = await _dio.get('v1/potholes/$potholeId');
      if (response.data['data']['pothole'] == null) {
        throw ApiDataException(
            'Error al recuperar datos. No se encontraron datos de pothole.');
      }
      return PotholeModel.fromJson(response.data['data']['pothole']);
    } on DioException catch (e) {
      final errorMessage = DioErrorHandler.getErrorMessage(e);
      throw NetworkException(errorMessage);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PotholeModel>> getPotholes(int page) async {
    try {
      final response = await _dio.get('v1/potholes?page=$page');
      if (response.data['data']['potholes'] == null) {
        throw ApiDataException(
            'Error al recuperar datos. No se encontraron datos de potholes.');
      }
      return (response.data['data']['potholes'] as List)
          .map((pothole) => PotholeModel.fromJson(pothole))
          .toList();
    } on DioException catch (e) {
      final errorMessage = DioErrorHandler.getErrorMessage(e);
      throw NetworkException(errorMessage);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<PotholeModel> savePotholeById(
      String potholeId, Map<String, dynamic> potholeLike) async {
    final method = potholeId == 'new' ? 'POST' : 'PATCH';
    final url = potholeId == 'new' ? 'v1/potholes' : 'v1/potholes/$potholeId';

    try {
      var data = potholeLike;

      if (potholeLike.containsKey('image') && potholeLike['image'] != '') {
        final mimeType = lookupMimeType(potholeLike['image']);

        if (mimeType == null) {
          throw ApiDataException(
              'Error al cargar imagen. El formato de la imagen no es valido.');
        }
        Uint8List image = File(potholeLike['image']).readAsBytesSync();
        final imageBase64 = base64Encode(image);

        data['image'] = imageBase64;     
      } else {
        if (method == 'POST') {
          throw ApiDataException(
              'Error al cargar imagen. La imagen es obligatoria');
        }
      }
      final response =
          await _dio.request(url, data: data, options: Options(method: method));

      if (response.data['data']['pothole'] == null) {
        throw ApiDataException(
            'Error al recuperar datos. No se encontraron datos de pothole.');
      }
      return PotholeModel.fromJson(response.data['data']['pothole']);
    } on DioException catch (e) {
      final errorMessage = DioErrorHandler.getErrorMessage(e);
      throw NetworkException(errorMessage);
    } catch (e) {
      throw Exception(e);
    }
  }
}
