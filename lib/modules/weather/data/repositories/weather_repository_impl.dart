import 'package:cloudwalk/modules/weather/data/mappers/current_weather_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_forecast_mapper.dart';
import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';
import 'package:cloudwalk/modules/weather/data/sources/local/local_weather_source.dart';
import 'package:cloudwalk/modules/weather/data/sources/remote/remote_weather_source.dart';
import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/repository_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_service.dart';
import 'package:dartz/dartz.dart';

/// [WeatherRepositoryImpl] is a repository that implements [WeatherRepository] and retrieves weather data from [RemoteWeatherSource] and [LocalWeatherSource].
class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteWeatherSource _remoteSource;
  final LocalWeatherSource _localSource;
  final ConnectivityService _connectivityService;
  final CurrentWeatherMapper _currentWeatherMapper;
  final WeatherForecastMapper _weatherForecastMapper;

  WeatherRepositoryImpl({
    required RemoteWeatherSource remoteSource,
    required LocalWeatherSource localSource,
    required ConnectivityService connectivityService,
    required CurrentWeatherMapper currentWeatherMapper,
    required WeatherForecastMapper weatherForecastMapper,
  })  : _remoteSource = remoteSource,
        _localSource = localSource,
        _connectivityService = connectivityService,
        _currentWeatherMapper = currentWeatherMapper,
        _weatherForecastMapper = weatherForecastMapper;

  bool get isOffline => _connectivityService.isOffline;

  @override
  Future<Either<Failure, CurrentWeatherEntity?>> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      Either<Failure, CurrentWeatherModel?> result;

      if (isOffline) {
        result = await _localSource.getCurrentWeather(
          lat: lat,
          lon: lon,
        );
      } else {
        result = await _remoteSource.getCurrentWeather(
          lat: lat,
          lon: lon,
        );
      }

      return result.fold(
        (failure) {
          return Left(failure);
        },
        (model) async {
          if (model == null) {
            return const Right(null);
          }

          if (!isOffline) {
            await saveCurrentWeather(lat: lat, lon: lon, model: model);
          }

          final entity = _currentWeatherMapper.toEntity(model);

          return Right(entity);
        },
      );
    } catch (e, s) {
      return Left(RepositoryFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<WeatherForecastEntity>?>> getWeatherForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      Either<Failure, List<WeatherForecastModel>?> result;

      if (isOffline) {
        result = await _localSource.getWeatherForecast(
          lat: lat,
          lon: lon,
        );
      } else {
        result = await _remoteSource.getWeatherForecast(
          lat: lat,
          lon: lon,
        );
      }

      return result.fold(
        (failure) {
          return Left(failure);
        },
        (models) async {
          if (models == null) {
            return const Right(null);
          }

          if (!isOffline) {
            await saveWeatherForecast(lat: lat, lon: lon, models: models);
          }

          final entities = models.map((model) {
            return _weatherForecastMapper.toEntity(model);
          }).toList();

          return Right(entities);
        },
      );
    } catch (e, s) {
      return Left(RepositoryFailure(error: e, stackTrace: s));
    }
  }

  Future saveCurrentWeather({
    required double lat,
    required double lon,
    required CurrentWeatherModel model,
  }) async {
    try {
      await _localSource.saveCurrentWeather(
        lat: lat,
        lon: lon,
        currentWeatherModel: model,
      );
    } catch (e, s) {
      return Left(RepositoryFailure(error: e, stackTrace: s));
    }
  }

  Future saveWeatherForecast({
    required double lat,
    required double lon,
    required List<WeatherForecastModel> models,
  }) async {
    try {
      await _localSource.saveWeatherForecast(
        lat: lat,
        lon: lon,
        weatherForecasts: models,
      );
    } catch (e, s) {
      return Left(RepositoryFailure(error: e, stackTrace: s));
    }
  }
}
