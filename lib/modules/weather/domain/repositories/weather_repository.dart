import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [WeatherRepository] is a repository that retrieves weather data.
abstract class WeatherRepository {
  /// Retrieves the current weather for the given latitude and longitude.
  ///
  /// Returns a [CurrentWeatherEntity] wrapped in an [Either] with a [Failure]
  /// if the operation fails.
  Future<Either<Failure, CurrentWeatherEntity?>> getCurrentWeather({
    required double lat,
    required double lon,
  });
  
  /// Retrieves the weather forecast for the given latitude and longitude.
  ///
  /// Returns a list of [WeatherForecastEntity] wrapped in an [Either] with a [Failure]
  /// if the operation fails.
  Future<Either<Failure, List<WeatherForecastEntity>?>> getWeatherForecast({
    required double lat,
    required double lon,
  });
}