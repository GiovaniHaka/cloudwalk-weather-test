import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherSource {
  Future<Either<Failure, CurrentWeatherModel>> getCurrentWeather({
    required double lat,
    required double lon,
  });
}
