import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/model_failure.dart';

class CurrentWeatherModel {
  final DateTime lastUpdate;
  final List<WeatherConditionModel> conditions;
  final WeatherMainModel main;

  CurrentWeatherModel({
    required this.lastUpdate,
    required this.conditions,
    required this.main,
  });

  static CurrentWeatherModel fromRemoteJson(Map json) {
    try {
      final conditions = (json['weather'] as List).map((e) {
        return WeatherConditionModel.fromRemoteJson(e);
      }).toList();

      final main = WeatherMainModel.fromRemoteJson(json['main']);

      return CurrentWeatherModel(
        lastUpdate: DateTime.now(),
        conditions: conditions,
        main: main,
      );
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }

  static CurrentWeatherModel fromLocalJson(Map map) {
    try {
      final conditions = (map['conditions'] as List).map((e) {
        return WeatherConditionModel.fromLocalJson(e);
      }).toList();

      final main = WeatherMainModel.fromLocalMap(map['main']);

      return CurrentWeatherModel(
        lastUpdate: DateTime.parse(map['lastUpdate']),
        conditions: conditions,
        main: main,
      );
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }

  toLocalMap() {
    return {
      'lastUpdate': lastUpdate.toIso8601String(),
      'conditions': conditions.map((e) => e.toLocalMap()).toList(),
      'main': main.toLocalMap(),
    };
  }
}
