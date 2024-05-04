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

  initialize() {
    _getCurrentWeather();
  }

  Future<void> _getCurrentWeather() async {
    try {
      _currentWeather.value = Loading();

      final result = await _getCurrentWeatherUsecase(
        lat: 0.0,
        lon: 0.0,
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
