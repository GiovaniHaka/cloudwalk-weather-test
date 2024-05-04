import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/modules/weather/data/repositories/weather_repository_impl.dart';
import 'package:cloudwalk/modules/weather/data/sources/remote/remote_weather_source_impl.dart';
import 'package:cloudwalk/modules/weather/data/sources/weather_source.dart';
import 'package:cloudwalk/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk/modules/weather/domain/usecases/get_current_weather_usecase.dart';
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
    _getIt.registerFactory<WeatherSource>(
      () => RemoteWeatherSourceImpl(
        apiClientService: _getIt.get(),
        endpoints: _getIt.get(),
        env: Env(),
      ),
    );

    /// [Repositories]
    _getIt.registerFactory<WeatherRepository>(
      () => WeatherRepositoryImpl(
        source: _getIt.get(),
      ),
    );

    /// [Usecases]
    _getIt.registerFactory<GetCurrentWeatherUsecase>(
      () => GetCurrentWeatherUsecaseImpl(
        repository: _getIt.get(),
      ),
    );

    /// [Controllers]
    _getIt.registerLazySingleton<CurrentWeatherController>(
      () => CurrentWeatherController(
        getCurrentWeatherUsecase: _getIt.get(),
      ),
    );
  }
}