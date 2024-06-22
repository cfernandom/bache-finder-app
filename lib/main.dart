import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/core/router/app_router.dart';
import 'package:bache_finder_app/features/shared/main_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Enviroment.initEnviroment();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bache Finder App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      initialBinding: MainBinding(),
      getPages: AppPages.pages
    );
  }
}