import 'package:cloudwalk/shared/commons/styles/app_colors.dart';
import 'package:flutter/material.dart';

/// [AppThemeData] is a class that contains the app theme data.
class AppThemeData {
  final BuildContext context;

  AppThemeData(this.context);

  ThemeData get theme => ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          foregroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primaryRegular,
          linearTrackColor: Colors.transparent,
        ),
        primaryColor: AppColors.primaryRegular,
      );
}
