import 'package:cloudwalk/shared/commons/failures/data_failures/model_failure.dart';

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

  static WeatherConditionModel fromJson(Map<String, dynamic> json) {
    try {
      final icon = json['icon'] as String;
      final iconUrl = 'https://openweathermap.org/img/wn/$icon@4x.png';

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
}
