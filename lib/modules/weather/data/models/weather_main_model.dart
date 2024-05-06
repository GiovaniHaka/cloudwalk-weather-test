import 'package:cloudwalk/shared/commons/failures/data_failures/model_failure.dart';

/// [WeatherMainModel] is a model that represents the main weather information.
class WeatherMainModel {
  final double temperature;
  final double maxTemperature;
  final double minTemperature;
  final double humidity;

  WeatherMainModel({
    required this.temperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
  });

  static WeatherMainModel fromRemoteJson(Map json) {
    try {
      return WeatherMainModel(
        temperature: json['temp'].toDouble(),
        maxTemperature: json['temp_max'].toDouble(),
        minTemperature: json['temp_min'].toDouble(),
        humidity: json['humidity'].toDouble(),
      );
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }

  static WeatherMainModel fromLocalMap(Map json) {
    try {
      return WeatherMainModel(
        temperature: json['temperature'],
        maxTemperature: json['maxTemperature'],
        minTemperature: json['minTemperature'],
        humidity: json['humidity'],
      );
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }

  toLocalMap() {
    return {
      'temperature': temperature,
      'maxTemperature': maxTemperature,
      'minTemperature': minTemperature,
      'humidity': humidity,
    };
  }
}
