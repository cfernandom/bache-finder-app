import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static initEnviroment() async {
    await dotenv.load(fileName: '.env');
  }

  static String bacheFinderApiUrl() {
    return dotenv.env['BACHE_FINDER_API_URL']!;
  }
}