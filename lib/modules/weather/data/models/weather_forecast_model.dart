import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:equatable/equatable.dart';

/// [WeatherForecastModel] is a model that represents the weather forecast.
class WeatherForecastModel extends Equatable {
  final DateTime? date;
  final List<WeatherConditionModel> conditions;
  final WeatherMainModel main;

  const WeatherForecastModel({
    required this.date,
    required this.conditions,
    required this.main,
  });

  /// Converts a [WeatherForecastModel] to a JSON map.
  Map toLocalMap() {
    return {
      'date': date?.toIso8601String(),
      'conditions': conditions.map((e) => e.toLocalMap()).toList(),
      'main': main.toLocalMap(),
    };
  }

  @override
  String toString() =>
      'WeatherForecastModel(date: $date, conditions: $conditions, main: $main)';

  @override
  List<Object?> get props => [date, conditions, main];
}
