import 'package:bache_finder_app/features/shared/services/storage_service.dart';
import 'package:bache_finder_app/features/shared/services/storage_service_impl.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Dio(), permanent: true);
    Get.put<StorageService>(StorageServiceImpl(), permanent: true);
  }
}
