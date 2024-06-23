import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/core/router/app_pages.dart';
import 'package:bache_finder_app/core/bindings/root_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await Enviroment.initEnviroment();
  await RootBinding.setupDependencies();
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
      initialRoute: AppPaths.authCheck,
      getPages: AppRouter.routes,
    );
  }
}
