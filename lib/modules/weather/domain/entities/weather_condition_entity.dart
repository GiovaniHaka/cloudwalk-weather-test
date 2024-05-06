/// [WeatherConditionEntity] is a class that contains the weather condition entity.
class WeatherConditionEntity {
 final int id;
  final String main;
  final String description;
  final String icon;
  final String iconUrl;

  WeatherConditionEntity({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.iconUrl,
  });
}