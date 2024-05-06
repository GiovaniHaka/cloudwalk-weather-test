import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/modules/weather/data/mappers/current_weather_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_condition_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_forecast_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_main_mapper.dart';
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
    /// [Mappers]
    _getIt.registerFactory<CurrentWeatherMapper>(
      () => CurrentWeatherMapper(
        weatherConditionMapper: _getIt.get(),
        weatherMainMapper: _getIt.get(),
      ),
    );

    _getIt.registerFactory<WeatherForecastMapper>(
      () => WeatherForecastMapper(
        weatherConditionMapper: _getIt.get(),
        weatherMainMapper: _getIt.get(),
      ),
    );

    _getIt.registerFactory<WeatherConditionMapper>(
      () => WeatherConditionMapper(),
    );

    _getIt.registerFactory<WeatherMainMapper>(
      () => WeatherMainMapper(),
    );

    /// [Sources]
    _getIt.registerFactory<RemoteWeatherSource>(
      () => RemoteWeatherSourceImpl(
        apiClientService: _getIt.get(),
        endpoints: _getIt.get(),
        env: Env(),
        currentWeatherMapper: _getIt.get(),
        weatherForecastMapper: _getIt.get(),
      ),
    );

    _getIt.registerFactory<LocalWeatherSource>(
      () => LocalWeatherSourceImpl(
        localDatabaseService: _getIt.get(),
        currentWeatherMapper: _getIt.get(),
        weatherForecastMapper: _getIt.get(),
      ),
    );

    /// [Repositories]
    _getIt.registerFactory<WeatherRepository>(
      () => WeatherRepositoryImpl(
        localSource: _getIt.get(),
        remoteSource: _getIt.get(),
        connectivityService: _getIt.get(),
        currentWeatherMapper: _getIt.get(),
        weatherForecastMapper: _getIt.get(),
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
