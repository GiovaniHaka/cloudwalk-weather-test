import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';
import 'package:equatable/equatable.dart';

/// [WeatherForecastEntity] is an entity that represents the weather forecast.
class WeatherForecastEntity extends Equatable {
  final DateTime? date;
  final List<WeatherConditionEntity> conditions;
  final WeatherMainEntity main;

 const  WeatherForecastEntity({
    required this.date,
    required this.conditions,
    required this.main,
  });

  @override
  List<Object?> get props => [date, conditions, main];
}