import 'package:bache_finder_app/core/constants/enviroment.dart';
import 'package:bache_finder_app/core/router/app_router.dart';
import 'package:bache_finder_app/features/auth/presentation/bindings/auth_bindings.dart';
import 'package:bache_finder_app/features/shared/presentation/widgets/snackbar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Enviroment.initEnviroment();
  AuthBindings().dependencies();
  if (kIsWeb) {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    usePathUrlStrategy();
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  final appRouterNotifier = Get.put(AppRouterNotifier());

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final appRouterNotifier = Get.find<AppRouterNotifier>();

    return MaterialApp.router(
      scaffoldMessengerKey: GlobalSnackbarWidget.scaffoldMessengerKey,
      title: 'Bache Finder App',
      routerConfig: AppRouter.createRouter(appRouterNotifier),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: kIsWeb
              ? {
                  for (final platform in TargetPlatform.values)
                    platform: const NoTransitionsBuilder(),
                }
              : const {},
        ),
      ),
    );
  }
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    return child!;
  }
}
