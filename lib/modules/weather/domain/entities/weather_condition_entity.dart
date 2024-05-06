import 'package:equatable/equatable.dart';

/// [WeatherConditionEntity] is a class that contains the weather condition entity.
class WeatherConditionEntity extends Equatable {
 final int id;
  final String main;
  final String description;
  final String icon;
  final String iconUrl;

  const WeatherConditionEntity({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [id, main, description, icon, iconUrl];
}