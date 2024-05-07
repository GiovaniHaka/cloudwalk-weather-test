/// [AppEndpoints] is an abstract class that contains the endpoints of the application.
abstract class AppEndpoints {
  String get currentWeather;
  String get weatherForecast;
}

/// [ProductionEndpointsImpl] is a class that contains the endpoints of the application.
class ProductionEndpointsImpl implements AppEndpoints {
  const ProductionEndpointsImpl();

  final String openWeatherUrl = 'https://api.openweathermap.org/data/2.5';

  @override
  String get currentWeather => '$openWeatherUrl/weather';

  @override
  String get weatherForecast => '$openWeatherUrl/forecast';
}
