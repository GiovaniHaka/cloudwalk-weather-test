import 'package:equatable/equatable.dart';

import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/model_failure.dart';

/// [CurrentWeatherModel] is a model that represents the current weather.
class CurrentWeatherModel extends Equatable {
  final DateTime lastUpdate;
  final List<WeatherConditionModel> conditions;
  final WeatherMainModel main;

  const CurrentWeatherModel({
    required this.lastUpdate,
    required this.conditions,
    required this.main,
  });

  Map toLocalMap() {
    try {
      return {
        'lastUpdate': lastUpdate.toIso8601String(),
        'conditions': conditions.map((e) => e.toLocalMap()).toList(),
        'main': main.toLocalMap(),
      };
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }

  @override
  List<Object?> get props => [lastUpdate, conditions, main];

  @override
  String toString() =>
      'CurrentWeatherModel(lastUpdate: $lastUpdate, conditions: $conditions, main: $main)';
}
