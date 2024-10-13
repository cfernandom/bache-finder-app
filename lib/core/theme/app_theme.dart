import 'package:bache_finder_app/core/constants/app_colors.dart';
import 'package:bache_finder_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.primaryColor,

      /// Text
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 96,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.blumine
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.blumine
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.blumine
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.blumine
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.blumine
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: AppColors.blumine
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          color: AppColors.blumine
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          color: AppColors.blumine
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          color: AppColors.blumine
        ),
      ),

      ///
      pageTransitionsTheme: PageTransitionsTheme(
        builders: kIsWeb
            ? {
                for (final platform in TargetPlatform.values)
                  platform: const NoTransitionsBuilder(),
              }
            : const {},
      ),
    );
  }
}
