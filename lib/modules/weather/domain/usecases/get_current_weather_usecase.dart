import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk/shared/commons/failures/domain_failures/usecase_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [GetCurrentWeatherUsecase] is a usecase that retrieves the current weather.
abstract class GetCurrentWeatherUsecase {
  Future<Either<Failure, CurrentWeatherEntity?>> call({
    required double lat,
    required double lon,
  });
}

/// [GetCurrentWeatherUsecaseImpl] is a usecase that retrieves the current weather.
class GetCurrentWeatherUsecaseImpl implements GetCurrentWeatherUsecase {
  final WeatherRepository _repository;

  GetCurrentWeatherUsecaseImpl({
    required WeatherRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, CurrentWeatherEntity?>> call({
    required double lat,
    required double lon,
  }) async {
    try {
      return await _repository.getCurrentWeather(
        lat: lat,
        lon: lon,
      );
    } catch (e, s) {
      return Left(UsecaseFailure(error: e, stackTrace: s));
    }
  }
}
