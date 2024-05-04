import 'package:cloudwalk/core/routers/app_router.dart';
import 'package:cloudwalk/shared/commons/styles/app_theme_data.dart';
import 'package:flutter/material.dart';

final router = AppRouter().router;

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weather App',
      theme: AppThemeData(context).theme,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
