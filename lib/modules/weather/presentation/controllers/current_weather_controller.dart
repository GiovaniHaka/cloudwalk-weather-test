import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/modules/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:cloudwalk/modules/weather/domain/usecases/get_weather_forecast_usecase.dart';
import 'package:cloudwalk/shared/commons/failures/presentation_failures/controller_failure.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:rx_notifier/rx_notifier.dart';

/// [CurrentWeatherController] is a controller that manages the current weather from a concert.
class CurrentWeatherController {
  final GetCurrentWeatherUsecase _getCurrentWeatherUsecase;
  final GetWeatherForecastUsecase _getWeatherForecastUsecase;

  CurrentWeatherController({
    required GetCurrentWeatherUsecase getCurrentWeatherUsecase,
    required GetWeatherForecastUsecase getWeatherForecastUsecase,
  })  : _getCurrentWeatherUsecase = getCurrentWeatherUsecase,
        _getWeatherForecastUsecase = getWeatherForecastUsecase;

  final _currentConcert = RxNotifier<ConcertEntity?>(null);
  ConcertEntity? get currentConcert => _currentConcert.value;

  AppState<CurrentWeatherEntity> get currentWeather => _currentWeather.value;
  final _currentWeather = RxNotifier<AppState<CurrentWeatherEntity>>(
    Initial(),
  );

  AppState<List<WeatherForecastEntity>> get forecasts => _forecasts.value;
  final _forecasts = RxNotifier<AppState<List<WeatherForecastEntity>>>(
    Initial(),
  );

  initialize() async {
    final concert = currentConcert;

    if (concert == null) {
      _currentWeather.value = Empty();
      _forecasts.value = Empty();
      return;
    }

    await Future.wait([
      getCurrentWeather(lat: concert.lat, lon: concert.lon),
      getWeatherForecast(lat: concert.lat, lon: concert.lon),
    ]);
  }

  onChangeConcert(ConcertEntity? concert) async {
    if (concert == null) {
      _currentConcert.value = concert;
      _currentWeather.value = Empty();
      _forecasts.value = Empty();
      return;
    }

    _currentConcert.value = concert;
    await Future.wait([
      getCurrentWeather(lat: concert.lat, lon: concert.lon),
      getWeatherForecast(lat: concert.lat, lon: concert.lon),
    ]);
  }

  Future<void> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      _currentWeather.value = Loading();

      final result = await _getCurrentWeatherUsecase(
        lat: lat,
        lon: lon,
      );

      result.fold(
        (failure) {
          _currentWeather.value = Error(failure);
        },
        (data) {
          if (data == null) {
            _currentWeather.value = Empty();
            return;
          }

          _currentWeather.value = Loaded(data);
        },
      );
    } catch (e, s) {
      _currentWeather.value = Error(ControllerFailure(error: e, stackTrace: s));
    }
  }

  Future<void> getWeatherForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      _forecasts.value = Loading();

      final result = await _getWeatherForecastUsecase(
        lat: lat,
        lon: lon,
      );

      result.fold(
        (failure) {
          _forecasts.value = Error(failure);
        },
        (data) {
          if (data == null || data.isEmpty) {
            _forecasts.value = Empty();
            return;
          }

          _forecasts.value = Loaded(data);
        },
      );
    } catch (e, s) {
      _forecasts.value = Error(ControllerFailure(error: e, stackTrace: s));
    }
  }
}
