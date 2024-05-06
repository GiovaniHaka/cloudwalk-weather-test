import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';
import 'package:cloudwalk/modules/weather/data/sources/weather_source.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [LocalWeatherSource] is an abstract source that implements [WeatherSource] and saves weather data locally.
abstract class LocalWeatherSource implements WeatherSource {
  Future<Either<Failure, void>> saveCurrentWeather({
    required double lat,
    required double lon,
    required CurrentWeatherModel currentWeatherModel,
  });

  Future<Either<Failure, void>> saveWeatherForecast({
    required double lat,
    required double lon,
    required List<WeatherForecastModel> weatherForecasts,
  });
}
