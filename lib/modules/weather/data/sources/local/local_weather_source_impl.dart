import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';
import 'package:cloudwalk/modules/weather/data/sources/local/local_weather_source.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/source_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:cloudwalk/shared/services/local_data/entities/local_data_input_entity.dart';
import 'package:cloudwalk/shared/services/local_data/entities/local_data_request_entity.dart';
import 'package:cloudwalk/shared/services/local_data/local_database_service.dart';
import 'package:dartz/dartz.dart';

class LocalWeatherSourceImpl implements LocalWeatherSource {
  final LocalDatabaseService _localDatabaseService;

  LocalWeatherSourceImpl({
    required LocalDatabaseService localDatabaseService,
  }) : _localDatabaseService = localDatabaseService;

  final currentWeatherTable = 'current_weather';
  final weatherForecastTable = 'weather_forecast';

  @override
  Future<Either<Failure, CurrentWeatherModel?>> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      final key = buildLatLonKey(lat, lon);

      final request = LocalDataRequestEntity(
        table: currentWeatherTable,
        key: key,
      );

      final data = await _localDatabaseService.get(
        request,
      );

      if (data == null) {
        return const Right(null);
      }

      final model = CurrentWeatherModel.fromLocalJson(data);

      return Right(model);
    } catch (e, s) {
      return Left(SourceFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<WeatherForecastModel>?>> getWeatherForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final key = buildLatLonKey(lat, lon);

      final request = LocalDataRequestEntity(
        table: weatherForecastTable,
        key: key,
      );

      final data = await _localDatabaseService.get(
        request,
      );

      if (data == null) {
        return const Right(null);
      }

      final models = (data as List).map((e) {
        return WeatherForecastModel.fromLocalJson(e);
      }).toList();

      return Right(models);
    } catch (e, s) {
      return Left(SourceFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, void>> saveCurrentWeather({
    required double lat,
    required double lon,
    required CurrentWeatherModel currentWeatherModel,
  }) async {
    try {
      final key = buildLatLonKey(lat, lon);

      final request = LocalDataInputEntity(
        key: key,
        table: currentWeatherTable,
        value: currentWeatherModel.toLocalMap(),
      );

      await _localDatabaseService.put(request);

      return const Right(null);
    } catch (e, s) {
      return Left(SourceFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, void>> saveWeatherForecast({
    required double lat,
    required double lon,
    required List<WeatherForecastModel> weatherForecasts,
  }) async {
    try {
      final key = buildLatLonKey(lat, lon);

      final request = LocalDataInputEntity(
        table: weatherForecastTable,
        key: key,
        value: weatherForecasts.map((e) => e.toLocalMap()).toList(),
      );

      await _localDatabaseService.put(request);

      return const Right(null);
    } catch (e, s) {
      return Left(SourceFailure(error: e, stackTrace: s));
    }
  }

  String buildLatLonKey(double lat, double lon) {
    return '${lat}_$lon';
  }
}
