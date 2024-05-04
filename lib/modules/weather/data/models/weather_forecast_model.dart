import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/model_failure.dart';

class WeatherForecastModel {
  final DateTime? date;
  final List<WeatherConditionModel> conditions;
  final WeatherMainModel main;

  WeatherForecastModel({
    required this.date,
    required this.conditions,
    required this.main,
  });

  static WeatherForecastModel fromJson(Map<String, dynamic> json) {
    try {
      final conditions = (json['weather'] as List).map((e) {
        return WeatherConditionModel.fromJson(e);
      }).toList();

      final main = WeatherMainModel.fromJson(json['main']);

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
}
