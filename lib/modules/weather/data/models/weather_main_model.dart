import 'package:equatable/equatable.dart';

/// [WeatherMainModel] is a model that represents the main weather information.
class WeatherMainModel extends Equatable {
  final double temperature;
  final double maxTemperature;
  final double minTemperature;
  final double humidity;

  const WeatherMainModel({
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
  });

  @override
  String toString() {
    return 'WeatherMainModel(temperature: $temperature, maxTemperature: $maxTemperature, minTemperature: $minTemperature, humidity: $humidity)';
  }

  /// Converts a [WeatherMainModel] to a JSON map.
  Map toLocalMap() {
    return {
      'temperature': temperature,
      'maxTemperature': maxTemperature,
      'minTemperature': minTemperature,
      'humidity': humidity,
    };
  }

  @override
  List<Object?> get props => [
        temperature,
        maxTemperature,
        minTemperature,
        humidity,
      ];
}
