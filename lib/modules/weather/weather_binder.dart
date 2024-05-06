import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/modules/weather/data/repositories/weather_repository_impl.dart';
import 'package:cloudwalk/modules/weather/data/sources/local/local_weather_source.dart';
import 'package:cloudwalk/modules/weather/data/sources/local/local_weather_source_impl.dart';
import 'package:cloudwalk/modules/weather/data/sources/remote/remote_weather_source_impl.dart';
import 'package:cloudwalk/modules/weather/data/sources/remote/remote_weather_source.dart';
import 'package:cloudwalk/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk/modules/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:cloudwalk/modules/weather/domain/usecases/get_weather_forecast_usecase.dart';
import 'package:cloudwalk/modules/weather/presentation/controllers/current_weather_controller.dart';
import 'package:cloudwalk/shared/services/env/env.dart';
import 'package:get_it/get_it.dart';

/// [WeatherBinder] is a class that binds all dependencies related to the weather module
class WeatherBinder implements Binder {
  final GetIt _getIt;

  WeatherBinder({
    required GetIt getIt,
  }) : _getIt = getIt;

  @override
  void bind() {
    /// [Sources]
    _getIt.registerFactory<RemoteWeatherSource>(
      () => RemoteWeatherSourceImpl(
        apiClientService: _getIt.get(),
        endpoints: _getIt.get(),
        env: Env(),
      ),
    );

    _getIt.registerFactory<LocalWeatherSource>(
      () => LocalWeatherSourceImpl(
        localDatabaseService: _getIt.get(),
      ),
    );

    /// [Repositories]
    _getIt.registerFactory<WeatherRepository>(
      () => WeatherRepositoryImpl(
        localSource: _getIt.get(),
        remoteSource: _getIt.get(),
        connectivityService: _getIt.get(),
      ),
    );

    /// [Usecases]
    _getIt.registerFactory<GetCurrentWeatherUsecase>(
      () => GetCurrentWeatherUsecaseImpl(
        repository: _getIt.get(),
      ),
    );

    _getIt.registerFactory<GetWeatherForecastUsecase>(
      () => GetWeatherForecastUsecaseImpl(
        repository: _getIt.get(),
      ),
    );

    /// [Controllers]
    _getIt.registerLazySingleton<CurrentWeatherController>(
      () => CurrentWeatherController(
        getCurrentWeatherUsecase: _getIt.get(),
        getWeatherForecastUsecase: _getIt.get(),
      ),
    );
  }
}
