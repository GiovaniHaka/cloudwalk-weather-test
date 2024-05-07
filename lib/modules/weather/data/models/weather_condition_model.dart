import 'package:equatable/equatable.dart';

/// [WeatherConditionModel] is a model that represents the weather condition.
class WeatherConditionModel extends Equatable {
  final int id;
  final String main;
  final String description;
  final String icon;
  final String iconUrl;

  const WeatherConditionModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.iconUrl,
  });

  static String getIconUrl(String icon) {
    return 'https://openweathermap.org/img/wn/$icon@4x.png';
  }


  Map toLocalMap() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  @override
  List<Object?> get props => [id, main, description, icon, iconUrl];

  @override
  String toString() {
    return 'WeatherConditionModel(id: $id, main: $main, description: $description, icon: $icon, iconUrl: $iconUrl)';
  }
}
