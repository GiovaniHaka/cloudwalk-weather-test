import 'package:cloudwalk/core/endpoints/app_endpoints.dart';
import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';
import 'package:cloudwalk/modules/weather/data/sources/remote/remote_weather_source.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/source_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:cloudwalk/shared/services/api_client/api_client_service.dart';
import 'package:cloudwalk/shared/services/api_client/exceptions/api_exception.dart';
import 'package:cloudwalk/shared/services/api_client/handlers/api_error_handler.dart';
import 'package:cloudwalk/shared/services/env/env.dart';
import 'package:dartz/dartz.dart';

/// [RemoteWeatherSourceImpl] is a source that retrieves weather data from a remote server.
class RemoteWeatherSourceImpl implements RemoteWeatherSource {
  final ApiClientService _apiClientService;
  final AppEndpoints _endpoints;
  final Env _env;

  RemoteWeatherSourceImpl({
    required ApiClientService apiClientService,
    required AppEndpoints endpoints,
    required Env env,
  })  : _apiClientService = apiClientService,
        _endpoints = endpoints,
        _env = env;

  @override
  Future<Either<Failure, CurrentWeatherModel>> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      final query = {
        'lat': lat,
        'lon': lon,
        'appid': _env.openWeatherApiKey,
        'units': 'metric',
        'lang': 'pt_br',
      };

      final response = await _apiClientService.get(
        path: _endpoints.currentWeather,
        queryParameters: query,
      );

      final data = response.data as Map<String, dynamic>;

      final model = CurrentWeatherModel.fromRemoteJson(data);

      return Right(model);
    } on ApiException catch (e) {
      final failure = ApiErrorHandler.mapErrorCode(e.errorCode);
      return Left(failure);
    } catch (e, s) {
      return Left(SourceFailure(error: e, stackTrace: s));
    }
  }

  @override
  Future<Either<Failure, List<WeatherForecastModel>>> getWeatherForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final query = {
        'lat': lat,
        'lon': lon,
        'appid': _env.openWeatherApiKey,
        'units': 'metric',
        'lang': 'pt_br',
      };

      final response = await _apiClientService.get(
        path: _endpoints.weatherForecast,
        queryParameters: query,
      );

      final data = response.data as Map<String, dynamic>;

      final list = data['list'] as List;

      final models = list.map((e) {
        return WeatherForecastModel.fromRemoteJson(e);
      }).toList();

      return Right(models);
    } on ApiException catch (e) {
      final failure = ApiErrorHandler.mapErrorCode(e.errorCode);
      return Left(failure);
    } catch (e, s) {
      return Left(SourceFailure(error: e, stackTrace: s));
    }
  }
}
