import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:cloudwalk/shared/commons/mapper/mapper.dart';

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
}
