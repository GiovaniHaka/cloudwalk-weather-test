import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';
import 'package:equatable/equatable.dart';

/// [CurrentWeatherEntity] is an entity that represents the current weather.
class CurrentWeatherEntity extends Equatable {
  final DateTime lastUpdate;
  final List<WeatherConditionEntity> conditions;
  final WeatherMainEntity main;

  const CurrentWeatherEntity({
    required this.lastUpdate,
    required this.conditions,
    required this.main,
  });

  @override
  List<Object?> get props => [lastUpdate, conditions, main];
}
