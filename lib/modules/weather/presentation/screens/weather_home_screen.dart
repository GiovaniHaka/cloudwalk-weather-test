import 'package:cloudwalk/modules/weather/presentation/views/failure_current_weather_view.dart';
import 'package:cloudwalk/modules/weather/presentation/views/loading_current_weather_view.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Language.instance.lang.currentWeather,
        ),
      ),
      body: RxBuilder(builder: (context) {
        final currentWeatherState = _currentWeatherController.currentWeather;

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
  }
}
