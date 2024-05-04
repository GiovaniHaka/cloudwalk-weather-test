import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:cloudwalk/shared/commons/mapper/mapper.dart';

class WeatherMainMapper implements Mapper<WeatherMainModel, WeatherMainEntity> {
  @override
  WeatherMainEntity toEntity(WeatherMainModel model) {
    try {
      return WeatherMainEntity(
        humidity: model.humidity,
        maxTemperature: model.maxTemperature,
        minTemperature: model.minTemperature,
        temperature: model.temperature,
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }

  @override
  WeatherMainModel toModel(WeatherMainEntity entity) {
    throw UnimplementedError();
  }
}
