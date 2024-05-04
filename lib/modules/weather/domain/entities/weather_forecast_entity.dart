import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';

class WeatherForecastEntity {
  final DateTime? date;
  final List<WeatherConditionEntity> conditions;
  final WeatherMainEntity main;

  WeatherForecastEntity({
    required this.date,
    required this.conditions,
    required this.main,
  });
}
