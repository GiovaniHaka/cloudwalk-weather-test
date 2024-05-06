import 'package:cloudwalk/shared/commons/failures/data_failures/model_failure.dart';

/// [WeatherConditionModel] is a model that represents the weather condition.
class WeatherConditionModel {
  final int id;
  final String main;
  final String description;
  final String icon;
  final String iconUrl;

  WeatherConditionModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.iconUrl,
  });

  static String getIconUrl(String icon) {
    return 'https://openweathermap.org/img/wn/$icon@4x.png';
  }

  static WeatherConditionModel fromRemoteJson(Map json) {
    try {
      final icon = json['icon'] as String;
      final iconUrl = getIconUrl(icon);

      return WeatherConditionModel(
          id: json['id'] as int,
          main: json['main'] as String,
          description: json['description'] as String,
          icon: icon,
          iconUrl: iconUrl);
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }

  static WeatherConditionModel fromLocalJson(Map map) {
    try {
      final icon = map['icon'] as String;
      final iconUrl = getIconUrl(icon);

      return WeatherConditionModel(
        id: map['id'],
        main: map['main'],
        description: map['description'],
        icon: icon,
        iconUrl: iconUrl,
      );
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }

  toLocalMap() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}
