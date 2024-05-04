import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';

class CurrentWeatherEntity {
  final String cityName;
  final String countryCode;
  final List<WeatherConditionEntity> conditions;
  final WeatherMainEntity main;

  CurrentWeatherEntity({
    required this.cityName,
    required this.countryCode,
    required this.conditions,
    required this.main,
  });
}
