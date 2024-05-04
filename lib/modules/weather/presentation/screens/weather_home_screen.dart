import 'package:cloudwalk/modules/concerts/concert_router.dart';
import 'package:cloudwalk/modules/weather/presentation/views/empty_concert_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/views/failure_current_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/views/loading_current_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/widgets/switch_concert_title.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
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
      final currentConcert = _currentWeatherController.currentConcert;

      return Scaffold(
        appBar: AppBar(
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
        body: Builder(builder: (context) {
          if (currentConcert == null) {
            return EmptyConcertWeatherView(
              onTapChooseConcert: handleSwitchConcert,
            );
          }

          if (currentWeatherState is Error) {
            final failure = currentWeatherState.failure;
            return FailureCurrentWeatherView(
              failure: failure,
              onTapTryAgain: handleTryAgain,
            );
          }

          if (currentWeatherState is Loaded) {
            final currentWeater = currentWeatherState.data;
            return LoadedCurrentWeatherView(
              currentWeather: currentWeater,
            );
          }

          return const LoadingCurrentWeatherView();
        }),
      );
    });
  }
}
