import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk/shared/commons/extensions/datetime_extension.dart';
import 'package:cloudwalk/shared/commons/failures/domain_failures/usecase_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [GetWeatherForecastUsecase] is a usecase that retrieves the weather forecast.
abstract class GetWeatherForecastUsecase {
  Future<Either<Failure, List<WeatherForecastEntity>?>> call({
    required double lat,
    required double lon,
  });
}

/// [GetWeatherForecastUsecaseImpl] is a usecase that retrieves the weather forecast.
class GetWeatherForecastUsecaseImpl implements GetWeatherForecastUsecase {
  final WeatherRepository _repository;

  GetWeatherForecastUsecaseImpl({
    required WeatherRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, List<WeatherForecastEntity>?>> call({
    required double lat,
    required double lon,
  }) async {
    try {
      final result = await _repository.getWeatherForecast(
        lat: lat,
        lon: lon,
      );

      return result.fold((l) {
        return Left(l);
      }, (forecasts) {
        final now = DateTime.now().withoutTime();

        if (forecasts == null) {
          return const Right(null);
        }

        forecasts.removeWhere((e) {
          return e.date?.withoutTime().isAtSameMomentAs(now) ?? false;
        });

        return Right(forecasts);
      });
    } catch (e, s) {
      return Left(UsecaseFailure(error: e, stackTrace: s));
    }
  }
}
