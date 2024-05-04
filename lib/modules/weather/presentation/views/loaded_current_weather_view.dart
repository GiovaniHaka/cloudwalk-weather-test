import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/modules/weather/presentation/widgets/current_weather_display.dart';
import 'package:cloudwalk/modules/weather/presentation/widgets/weather_forecast_display.dart';
import 'package:flutter/material.dart';

class LoadedCurrentWeatherView extends StatelessWidget {
  final CurrentWeatherEntity currentWeather;
  final List<WeatherForecastEntity> forecasts;

  const LoadedCurrentWeatherView({
    Key? key,
    required this.currentWeather,
    required this.forecasts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: CurrentTemperatureDisplay(
              currentWeatherEntity: currentWeather,
            ),
          ),
          Center(
            child: WeatherForecastDisplay(
              forecasts: forecasts,
            ),
          ),
        ],
      ),
    );
  }
}
