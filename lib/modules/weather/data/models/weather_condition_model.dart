import 'package:cloudwalk/shared/commons/failures/data_failures/model_failure.dart';

class WeatherConditionModel {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherConditionModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  static WeatherConditionModel fromJson(Map<String, dynamic> json) {
    try {
      return WeatherConditionModel(
        id: json['id'] as int,
        main: json['main'] as String,
        description: json['description'] as String,
        icon: json['icon'] as String,
      );
    } catch (e, s) {
      throw ModelFailure(error: e, stackTrace: s);
    }
  }
}
