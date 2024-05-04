import 'package:cloudwalk/shared/commons/failures/data_failures/model_failure.dart';

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

  static WeatherMainModel fromJson(Map<String, dynamic> json) {
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
}
