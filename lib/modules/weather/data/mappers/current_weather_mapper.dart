import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_condition_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_main_mapper.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:cloudwalk/shared/commons/mapper/mapper.dart';

class CurrentWeatherMapper
    implements Mapper<CurrentWeatherModel, CurrentWeatherEntity> {
  @override
  CurrentWeatherEntity toEntity(CurrentWeatherModel model) {
    try {
      final conditions = (model.conditions).map((e) {
        return WeatherConditionMapper().toEntity(e);
      }).toList();

      final main = WeatherMainMapper().toEntity(model.main);

      return CurrentWeatherEntity(
        cityName: model.cityName,
        countryCode: model.countryCode,
        conditions: conditions,
        main: main,
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }

  @override
  CurrentWeatherModel toModel(CurrentWeatherEntity entity) {
    throw UnimplementedError();
  }
}
