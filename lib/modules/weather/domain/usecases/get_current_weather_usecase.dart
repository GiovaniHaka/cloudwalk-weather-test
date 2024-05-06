import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

abstract class GetCurrentWeatherUsecase {
  Future<Either<Failure, CurrentWeatherEntity?>> call({
    required double lat,
    required double lon,
  });
}

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
      return Left(Failure(error: e, stackTrace: s));
    }
  }
}
