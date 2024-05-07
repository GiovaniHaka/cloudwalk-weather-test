import 'package:cloudwalk/core/endpoints/app_endpoints.dart';
import 'package:cloudwalk/modules/weather/data/mappers/current_weather_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_forecast_mapper.dart';
import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';
import 'package:cloudwalk/modules/weather/data/sources/remote/remote_weather_source.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/source_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:cloudwalk/shared/services/api_client/api_client_service.dart';
import 'package:cloudwalk/shared/services/api_client/exceptions/api_exception.dart';
import 'package:cloudwalk/shared/services/api_client/handlers/api_error_handler.dart';
import 'package:cloudwalk/shared/services/env/env.dart';
import 'package:cloudwalk/shared/services/locale/locale_service.dart';
import 'package:dartz/dartz.dart';

/// [RemoteWeatherSourceImpl] is a source that retrieves weather data from a remote server.
class RemoteWeatherSourceImpl implements RemoteWeatherSource {
  final ApiClientService _apiClientService;
  final AppEndpoints _endpoints;
  final Env _env;
  final CurrentWeatherMapper _currentWeatherMapper;
  final WeatherForecastMapper _weatherForecastMapper;
  final LocaleService _localeService;

  RemoteWeatherSourceImpl({
    required ApiClientService apiClientService,
    required AppEndpoints endpoints,
    required Env env,
    required CurrentWeatherMapper currentWeatherMapper,
    required WeatherForecastMapper weatherForecastMapper,
    required LocaleService localeService,
  })  : _apiClientService = apiClientService,
        _endpoints = endpoints,
        _env = env,
        _currentWeatherMapper = currentWeatherMapper,
        _weatherForecastMapper = weatherForecastMapper,
        _localeService = localeService;

  String get lang => _localeService.getCurrentLocale();

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
        'lang': lang,
      };

      final response = await _apiClientService.get(
        path: _endpoints.currentWeather,
        queryParameters: query,
      );

      final data = response.data;

      final lastUpdate = DateTime.now();

      final model = _currentWeatherMapper.fromRemoteJson(data, lastUpdate);

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
        'lang': lang,
      };

      final response = await _apiClientService.get(
        path: _endpoints.weatherForecast,
        queryParameters: query,
      );

      final data = response.data;

      final list = data['list'] as List;

      final models = list.map((e) {
        return _weatherForecastMapper.fromRemoteJson(e);
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
