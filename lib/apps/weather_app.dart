import 'package:cloudwalk/shared/commons/styles/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../modules/home/home_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: AppThemeData(context).theme,
      home: const HomeScreen(
        title: 'Weather App',
      ),
    );
  }
}
