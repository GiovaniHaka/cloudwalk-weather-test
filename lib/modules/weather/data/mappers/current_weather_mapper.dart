import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_condition_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_main_mapper.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:cloudwalk/shared/commons/mapper/mapper.dart';

/// [CurrentWeatherMapper] is a mapper that converts [CurrentWeatherModel] to [CurrentWeatherEntity].
class CurrentWeatherMapper
    implements Mapper<CurrentWeatherModel, CurrentWeatherEntity> {
  final WeatherConditionMapper _weatherConditionMapper;
  final WeatherMainMapper _weatherMainMapper;

  CurrentWeatherMapper({
    required WeatherConditionMapper weatherConditionMapper,
    required WeatherMainMapper weatherMainMapper,
  })  : _weatherConditionMapper = weatherConditionMapper,
        _weatherMainMapper = weatherMainMapper;

  @override
  CurrentWeatherEntity toEntity(CurrentWeatherModel model) {
    try {
      final conditions = (model.conditions).map((e) {
        return _weatherConditionMapper.toEntity(e);
      }).toList();

      final main = _weatherMainMapper.toEntity(model.main);

      return CurrentWeatherEntity(
        lastUpdate: model.lastUpdate,
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

  CurrentWeatherModel fromRemoteJson(Map json, DateTime lastUpdate) {
    try {
      final conditions = (json['weather'] as List).map((e) {
        return _weatherConditionMapper.fromRemoteJson(e);
      }).toList();

      final main = _weatherMainMapper.fromRemoteJson(json['main']);

      return CurrentWeatherModel(
        lastUpdate: lastUpdate,
        conditions: conditions,
        main: main,
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }

  CurrentWeatherModel fromLocalJson(Map map) {
    try {
      final conditions = (map['conditions'] as List).map((e) {
        return _weatherConditionMapper.fromLocalJson(e);
      }).toList();

      final main = _weatherMainMapper.fromLocalJson(map['main']);

      return CurrentWeatherModel(
        lastUpdate: DateTime.parse(map['lastUpdate']),
        conditions: conditions,
        main: main,
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }
}
