import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/features/auth/presentation/controllers/session_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  late Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: Enviroment.bacheFinderApiUrl(),
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final sessionController = Get.find<SessionController>();
          String token = sessionController.session?.token ?? '';

          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  static DioClient getInstance() {
    return _instance;
  }
}
