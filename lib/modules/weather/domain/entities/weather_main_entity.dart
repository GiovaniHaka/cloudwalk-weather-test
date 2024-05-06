import 'package:cloudwalk/shared/commons/extensions/double_extension.dart';

/// [WeatherMainEntity] is an entity that represents the main weather data.
class WeatherMainEntity {
  final double temperature;
  final double maxTemperature;
  final double minTemperature;
  final double humidity;

  WeatherMainEntity({
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
  });

  String get temperatureWithUnits {
    return temperature.toTemperature();
  }

  String get maxTemperatureWithUnits {
    return maxTemperature.toTemperature();
  }

  String get minTemperatureWithUnits {
    return minTemperature.toTemperature();
  }
}
