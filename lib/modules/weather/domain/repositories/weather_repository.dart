import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherRepository {
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather({
    required double lat,
    required double lon,
  });
  
  Future<Either<Failure, List<WeatherForecastEntity>>> getWeatherForecast({
    required double lat,
    required double lon,
  });
}