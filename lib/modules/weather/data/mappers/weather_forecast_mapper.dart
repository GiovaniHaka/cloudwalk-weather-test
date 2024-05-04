import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_condition_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_main_mapper.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:cloudwalk/shared/commons/mapper/mapper.dart';

class WeatherForecastMapper
    implements Mapper<WeatherForecastModel, WeatherForecastEntity> {
  @override
  WeatherForecastEntity toEntity(WeatherForecastModel model) {
    try {
      final conditions = (model.conditions).map((e) {
        return WeatherConditionMapper().toEntity(e);
      }).toList();

      final main = WeatherMainMapper().toEntity(model.main);


      return WeatherForecastEntity(
        date: model.date,
        conditions: conditions,
        main: main,
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }

  @override
  WeatherForecastModel toModel(WeatherForecastEntity entity) {
    throw UnimplementedError();
  }
}
