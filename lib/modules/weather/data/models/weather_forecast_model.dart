import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/model_failure.dart';

/// [WeatherForecastModel] is a model that represents the weather forecast.
class WeatherForecastModel {
  final DateTime? date;
  final List<WeatherConditionModel> conditions;
  final WeatherMainModel main;

  WeatherForecastModel({
    required this.date,
    required this.conditions,
    required this.main,
  });

  static WeatherForecastModel fromRemoteJson(Map json) {
    try {
      final conditions = (json['weather'] as List).map((e) {
        return WeatherConditionModel.fromRemoteJson(e);
      }).toList();

      final main = WeatherMainModel.fromRemoteJson(json['main']);

      final date = DateTime.tryParse(json['dt_txt']);

      return WeatherForecastModel(
        conditions: conditions,
        main: main,
        date: date,
      );
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }

  static WeatherForecastModel fromLocalJson(Map json) {
    try {
      final conditions = (json['conditions'] as List).map((e) {
        return WeatherConditionModel.fromLocalJson(e);
      }).toList();

      final main = WeatherMainModel.fromLocalMap(json['main']);

      return WeatherForecastModel(
        date: DateTime.tryParse(json['date']),
        conditions: conditions,
        main: main,
      );
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }

  toLocalMap() {
    return {
      'date': date?.toIso8601String(),
      'conditions': conditions.map((e) => e.toLocalMap()).toList(),
      'main': main.toLocalMap(),
    };
  }
}
