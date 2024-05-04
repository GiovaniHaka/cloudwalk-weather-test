import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/modules/concerts/concert_router.dart';
import 'package:cloudwalk/modules/weather/presentation/views/empty_concert_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/views/failure_current_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/views/loading_current_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/widgets/switch_concert_title.dart';
import 'package:cloudwalk/shared/commons/app_bar/app_top_bar.dart';
import 'package:cloudwalk/shared/commons/logs/colorful_logs.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_service.dart';
import 'package:flutter/material.dart';

import 'package:cloudwalk/modules/weather/presentation/controllers/current_weather_controller.dart';
import 'package:cloudwalk/modules/weather/presentation/views/loaded_current_weather_view.dart';
import 'package:rx_notifier/rx_notifier.dart';

class WeatherHomeScreen extends StatefulWidget {
  final CurrentWeatherController currentWeatherController;

  const WeatherHomeScreen({
    Key? key,
    required this.currentWeatherController,
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

    final connect = getIt.get<ConnectivityService>().state;

    logSuccess('ConnectivityService: $connect');
  }

  handleTryAgain() {
    _currentWeatherController.initialize();
  }

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
          title: Builder(builder: (context) {
            if (currentConcert != null) {
              return SwitchConcertTitle(
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
                onTapChooseConcert: handleSwitchConcert,
              );
            }

            if (currentWeatherState is Error || weatherForecastState is Error) {
              final failure = currentWeatherState is Error
                  ? currentWeatherState.failure
                  : weatherForecastState.failure;

              return FailureCurrentWeatherView(
                failure: failure,
                onTapTryAgain: handleTryAgain,
              );
            }

            if (currentWeatherState is Loaded &&
                weatherForecastState is Loaded) {
              final currentWeater = currentWeatherState.data;
              final forescast = weatherForecastState.data;

              return LoadedCurrentWeatherView(
                currentWeather: currentWeater,
                forecasts: forescast,
              );
            }

            return const LoadingCurrentWeatherView();
          }),
        ),
      );
    });
  }
}
