abstract class AppEndpoints {
  String get currentWeather;
  String get weatherForecast;
}

class AppEndpointsImpl implements AppEndpoints {
  const AppEndpointsImpl();

  final String openWeatherUrl = 'https://api.openweathermap.org/data/2.5';

  @override
  String get currentWeather => '$openWeatherUrl/weather';

  @override
  String get weatherForecast => '$openWeatherUrl/forecast';
}

