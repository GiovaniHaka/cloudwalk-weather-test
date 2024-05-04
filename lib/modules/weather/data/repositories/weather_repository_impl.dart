import 'package:cloudwalk/modules/weather/data/mappers/current_weather_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_forecast_mapper.dart';
import 'package:cloudwalk/modules/weather/data/sources/weather_source.dart';
import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/repository_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherSource _source;

  WeatherRepositoryImpl({
    required WeatherSource source,
  }) : _source = source;

  @override
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      final result = await _source.getCurrentWeather(
        lat: lat,
        lon: lon,
      );

      return result.fold(
        (failure) {
          return Left(failure);
        },
        (model) {
          final entity = CurrentWeatherMapper().toEntity(model);
          return Right(entity);
        },
      );
    } catch (e, s) {
      return Left(RepositoryFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<WeatherForecastEntity>>> getWeatherForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final result = await _source.getWeatherForecast(
        lat: lat,
        lon: lon,
      );

      return result.fold(
        (failure) {
          return Left(failure);
        },
        (models) {
          final entities = models.map((model) {
            return WeatherForecastMapper().toEntity(model);
          }).toList();
          
          return Right(entities);
        },
      );
    } catch (e, s) {
      return Left(RepositoryFailure(error: e, stackTrace: s));
    }
  }
}
