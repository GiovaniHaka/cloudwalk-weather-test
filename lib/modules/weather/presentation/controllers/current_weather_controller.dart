import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:cloudwalk/shared/commons/failures/presentation_failures/controller_failure.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:rx_notifier/rx_notifier.dart';

class CurrentWeatherController {
  final GetCurrentWeatherUsecase _getCurrentWeatherUsecase;

  CurrentWeatherController({
    required GetCurrentWeatherUsecase getCurrentWeatherUsecase,
  }) : _getCurrentWeatherUsecase = getCurrentWeatherUsecase;

  final _currentWeather = RxNotifier<AppState<CurrentWeatherEntity>>(Initial());
  AppState<CurrentWeatherEntity> get currentWeather => _currentWeather.value;

  final _currentConcert = RxNotifier<ConcertEntity?>(null);
  ConcertEntity? get currentConcert => _currentConcert.value;

  initialize() {
    final concert = currentConcert;

    if (concert == null) {
      _currentWeather.value = Empty();
      return;
    }

    _getCurrentWeather(
      lat: concert.lat,
      lon: concert.lon,
    );
  }

  onChangeConcert(ConcertEntity? concert) {
    if (concert != null) {
      _currentConcert.value = concert;
      _getCurrentWeather(
        lat: concert.lat,
        lon: concert.lon,
      );
    }
  }

  Future<void> _getCurrentWeather({
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
          _currentWeather.value = Loaded(data);
        },
      );
    } catch (e, s) {
      _currentWeather.value = Error(ControllerFailure(error: e, stackTrace: s));
    }
  }
}
