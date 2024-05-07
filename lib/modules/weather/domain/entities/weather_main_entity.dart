import 'package:cloudwalk/shared/commons/extensions/double_extension.dart';
import 'package:equatable/equatable.dart';

/// [WeatherMainEntity] is an entity that represents the main weather data.
class WeatherMainEntity extends Equatable {
  final double temperature;
  final double maxTemperature;
  final double minTemperature;
  final double humidity;

  const WeatherMainEntity({
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

  @override
  List<Object?> get props =>
      [temperature, maxTemperature, minTemperature, humidity];
}
