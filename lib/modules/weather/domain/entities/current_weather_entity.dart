import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';

class CurrentWeatherEntity {
  final DateTime lastUpdate;
  final List<WeatherConditionEntity> conditions;
  final WeatherMainEntity main;

  CurrentWeatherEntity({
    required this.lastUpdate,
    required this.conditions,
    required this.main,
  });
}
