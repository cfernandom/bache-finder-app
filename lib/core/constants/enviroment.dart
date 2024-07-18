import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static initEnviroment() async {
    await dotenv.load(fileName: '.env');
  }

  static String bacheFinderApiUrl() {
    return dotenv.env['BACHE_FINDER_API_URL']!;
  }

  static String bacheFinderPublicStorageUrl() {
    return dotenv.env['BACHE_FINDER_PUBLIC_STORAGE_URL']!;
  }

  static String googleMapsApiKey() {
    return dotenv.env['GOOGLE_MAPS_API_KEY']!;
  }

  static String googleMapsApiProxyUrl() {
    return dotenv.env['GOOGLE_MAPS_API_PROXY_URL']!;
  }
}
