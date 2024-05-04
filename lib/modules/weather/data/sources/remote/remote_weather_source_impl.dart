import 'package:cloudwalk/core/endpoints/app_endpoints.dart';
import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/data/sources/weather_source.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/source_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:cloudwalk/shared/services/api_client/api_client_service.dart';
import 'package:cloudwalk/shared/services/api_client/exceptions/api_exception.dart';
import 'package:cloudwalk/shared/services/api_client/handlers/api_error_handler.dart';
import 'package:cloudwalk/shared/services/env/env.dart';
import 'package:dartz/dartz.dart';

class RemoteWeatherSourceImpl implements WeatherSource {
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

      final model = CurrentWeatherModel.fromJson(data);

      return Right(model);
    } on ApiException catch (e) {
      final failure = ApiErrorHandler.mapErrorCode(e.errorCode);
      return Left(failure);
    } catch (e, s) {
      return Left(SourceFailure(error: e, stackTrace: s));
    }
  }
}
