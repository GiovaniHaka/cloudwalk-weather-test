import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:get_it/get_it.dart';

abstract class AppEndpoints {
  String get currentWeather;
}

class AppEndpointsImpl implements AppEndpoints {
  const AppEndpointsImpl();

  final String openWeatherUrl = 'https://api.openweathermap.org/data/2.5';

  @override
  String get currentWeather => '$openWeatherUrl/weather';
}

class AppEndpointsBinder implements Binder {
  final GetIt _getIt;

  const AppEndpointsBinder({
    required GetIt getIt,
  }) : _getIt = getIt;

  @override
  void bind() {
    _getIt.registerSingleton<AppEndpoints>(const AppEndpointsImpl());
  }
}
