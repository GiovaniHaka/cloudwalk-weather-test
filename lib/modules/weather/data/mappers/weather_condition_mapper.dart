import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:cloudwalk/shared/commons/mapper/mapper.dart';

/// [WeatherConditionMapper] is a mapper that converts [WeatherConditionModel] to [WeatherConditionEntity].
class WeatherConditionMapper implements Mapper<WeatherConditionModel, WeatherConditionEntity> {
  @override
  WeatherConditionEntity toEntity(WeatherConditionModel model) {
    try {
      return WeatherConditionEntity(
        id: model.id,
        description: model.description,
        icon: model.icon,
        main: model.main,
        iconUrl: model.iconUrl,
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }

  @override
  WeatherConditionModel toModel(WeatherConditionEntity entity) {
    throw UnimplementedError();
  }


   WeatherConditionModel fromRemoteJson(Map json) {
    try {
      final icon = json['icon'] as String;
      final iconUrl = WeatherConditionModel.getIconUrl(icon);

      return WeatherConditionModel(
          id: json['id'] as int,
          main: json['main'] as String,
          description: json['description'] as String,
          icon: icon,
          iconUrl: iconUrl);
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }

   WeatherConditionModel fromLocalJson(Map map) {
    try {
      final icon = map['icon'] as String;
      final iconUrl = WeatherConditionModel.getIconUrl(icon);

      return WeatherConditionModel(
        id: map['id'],
        main: map['main'],
        description: map['description'],
        icon: icon,
        iconUrl: iconUrl,
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }
}
