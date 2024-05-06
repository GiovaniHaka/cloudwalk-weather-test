import 'package:cloudwalk/modules/concerts/concert_router.dart';
import 'package:cloudwalk/modules/weather/weather_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// [AppRouter] is a class that defines the app routes.
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: WeatherRouter.currentWeather,
    routes: [
      ...WeatherRouter().routes(),
      ...ConcertRouter().routes(),
    ],
  );
}
