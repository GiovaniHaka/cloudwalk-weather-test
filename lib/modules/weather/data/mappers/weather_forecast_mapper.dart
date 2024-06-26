import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_condition_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_main_mapper.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:cloudwalk/shared/commons/mapper/mapper.dart';

/// [WeatherForecastMapper] is a mapper that converts [WeatherForecastModel] to [WeatherForecastEntity].
class WeatherForecastMapper
    implements Mapper<WeatherForecastModel, WeatherForecastEntity> {
  final WeatherConditionMapper _weatherConditionMapper;
  final WeatherMainMapper _weatherMainMapper;

  WeatherForecastMapper({
    required WeatherConditionMapper weatherConditionMapper,
    required WeatherMainMapper weatherMainMapper,
  })  : _weatherConditionMapper = weatherConditionMapper,
        _weatherMainMapper = weatherMainMapper;

  @override
  WeatherForecastEntity toEntity(WeatherForecastModel model) {
    try {
      final conditions = (model.conditions).map((e) {
        return _weatherConditionMapper.toEntity(e);
      }).toList();

      final main = _weatherMainMapper.toEntity(model.main);

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

  WeatherForecastModel fromRemoteJson(Map json) {
    try {
      final conditions = (json['weather'] as List).map((e) {
        return _weatherConditionMapper.fromRemoteJson(e);
      }).toList();

      final main = _weatherMainMapper.fromRemoteJson(json['main']);

      final date = DateTime.tryParse(json['dt_txt']);

      return WeatherForecastModel(
        conditions: conditions,
        main: main,
        date: date,
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }

  WeatherForecastModel fromLocalJson(Map json) {
    try {
      final conditions = (json['conditions'] as List).map((e) {
        return _weatherConditionMapper.fromLocalJson(e);
      }).toList();

      final main = _weatherMainMapper.fromLocalJson(json['main']);

      return WeatherForecastModel(
        date: DateTime.tryParse(json['date']),
        conditions: conditions,
        main: main,
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }
}
