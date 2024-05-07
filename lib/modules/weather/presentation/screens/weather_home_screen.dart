import 'package:cloudwalk/modules/concerts/concert_router.dart';
import 'package:cloudwalk/modules/weather/presentation/views/empty_concert_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/views/empty_local_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/views/failure_current_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/views/loading_current_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/widgets/switch_concert_title.dart';
import 'package:cloudwalk/shared/commons/app_bar/app_top_bar.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_service.dart';
import 'package:flutter/material.dart';

import 'package:cloudwalk/modules/weather/presentation/controllers/current_weather_controller.dart';
import 'package:cloudwalk/modules/weather/presentation/views/loaded_current_weather_view.dart';
import 'package:rx_notifier/rx_notifier.dart';

/// [WeatherHomeScreen] is a screen that shows the current weather from a concert.
class WeatherHomeScreen extends StatefulWidget {
  final CurrentWeatherController currentWeatherController;
  final ConnectivityService connectivityService;

  const WeatherHomeScreen({
    Key? key,
    required this.currentWeatherController,
    required this.connectivityService,
  }) : super(key: key);

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  late final CurrentWeatherController _currentWeatherController;

  @override
  void initState() {
    super.initState();
    _currentWeatherController = widget.currentWeatherController;
    _currentWeatherController.initialize();

    rxObserver(() {
      if (!widget.connectivityService.isOffline) {
        _currentWeatherController.initialize();
      }
    });
  }

  /// Callback function to handle the "Try Again" action.
  handleTryAgain() {
    _currentWeatherController.initialize();
  }

  /// Callback function to handle the switch to the concerts screen.
  handleSwitchConcert() {
    ConcertRouter.goToConcerts(context);
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(builder: (context) {
      final currentWeatherState = _currentWeatherController.currentWeather;
      final weatherForecastState = _currentWeatherController.forecasts;
      final currentConcert = _currentWeatherController.currentConcert;

      return Scaffold(
        appBar: AppTopBar(
          key: const Key('appTopBarKey'),
          title: Builder(builder: (context) {
            if (currentConcert != null) {
              return SwitchConcertTitle(
                key: const Key('switchConcertTitleKey'),
                concert: currentConcert,
                onTap: handleSwitchConcert,
              );
            }

            return const SizedBox.shrink();
          }),
        ),
        body: SafeArea(
          child: Builder(builder: (context) {
            if (currentConcert == null) {
              return EmptyConcertWeatherView(
                key: const Key('emptyConcertWeatherViewKey'),
                onTapChooseConcert: handleSwitchConcert,
              );
            }

            if (currentWeatherState is Empty || weatherForecastState is Empty) {
              return const EmptyLocalWeatherView(
                key: Key('emptyLocalWeatherViewKey'),
              );
            }

            if (currentWeatherState is Error || weatherForecastState is Error) {
              final failure = currentWeatherState is Error
                  ? currentWeatherState.failure
                  : weatherForecastState.failure;

              return FailureCurrentWeatherView(
                key: const Key('failureCurrentWeatherViewKey'),
                failure: failure,
                onTapTryAgain: handleTryAgain,
              );
            }

            if (currentWeatherState is Loaded &&
                weatherForecastState is Loaded) {
              final currentWeater = currentWeatherState.data;
              final forescast = weatherForecastState.data;

              return LoadedCurrentWeatherView(
                key: const Key('loadedCurrentWeatherViewKey'),
                currentWeather: currentWeater,
                forecasts: forescast,
              );
            }

            return const LoadingCurrentWeatherView(
              key: Key('loadingCurrentWeatherViewKey'),
            );
          }),
        ),
      );
    });
  }
}
