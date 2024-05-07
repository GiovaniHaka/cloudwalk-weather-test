import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:cloudwalk/shared/commons/mapper/mapper.dart';

/// [WeatherMainMapper] is a mapper that converts [WeatherMainModel] to [WeatherMainEntity].
class WeatherMainMapper implements Mapper<WeatherMainModel, WeatherMainEntity> {
  /// Converts a [WeatherMainModel] to a [WeatherMainEntity].
  ///
  /// Throws a [MapperFailure] if an error occurs during the conversion.
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

  /// Converts a [WeatherMainEntity] to a [WeatherMainModel].
  ///
  /// Throws an [UnimplementedError] as this method is not implemented.
  @override
  WeatherMainModel toModel(WeatherMainEntity entity) {
    throw UnimplementedError();
  }

  /// Converts a JSON map to a [WeatherMainModel].
  ///
  /// Throws a [MapperFailure] if an error occurs during the conversion.
  WeatherMainModel fromRemoteJson(Map json) {
    try {
      return WeatherMainModel(
        temperature: json['temp'].toDouble(),
        maxTemperature: json['temp_max'].toDouble(),
        minTemperature: json['temp_min'].toDouble(),
        humidity: json['humidity'].toDouble(),
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }

  /// Converts a JSON map to a [WeatherMainModel].
  ///
  /// Throws a [MapperFailure] if an error occurs during the conversion.
  WeatherMainModel fromLocalJson(Map json) {
    try {
      return WeatherMainModel(
        temperature: json['temperature'].toDouble(),
        maxTemperature: json['maxTemperature'].toDouble(),
        minTemperature: json['minTemperature'].toDouble(),
        humidity: json['humidity'].toDouble(),
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }
}
