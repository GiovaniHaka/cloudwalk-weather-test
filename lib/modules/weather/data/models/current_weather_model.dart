import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/model_failure.dart';

class CurrentWeatherModel {
  final String cityName;
  final String countryCode;
  final List<WeatherConditionModel> conditions;
  final WeatherMainModel main;

  CurrentWeatherModel({
    required this.cityName,
    required this.countryCode,
    required this.conditions,
    required this.main,
  });

  static CurrentWeatherModel fromJson(Map<String, dynamic> json) {
    try {
      final conditions = (json['weather'] as List).map((e) {
        return WeatherConditionModel.fromJson(e);
      }).toList();

      final main = WeatherMainModel.fromJson(json['main']);

      return CurrentWeatherModel(
        cityName: json['name'],
        countryCode: json['sys']['country'],
        conditions: conditions,
        main: main,
      );
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }
}
