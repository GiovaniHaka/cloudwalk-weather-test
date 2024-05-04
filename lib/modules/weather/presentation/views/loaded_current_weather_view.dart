import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/presentation/widgets/current_weather_display.dart';
import 'package:flutter/material.dart';

class LoadedCurrentWeatherView extends StatelessWidget {
  final CurrentWeatherEntity currentWeather;

  const LoadedCurrentWeatherView({
    Key? key,
    required this.currentWeather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurrentTemperatureDisplay(
              currentWeatherEntity: currentWeather,
            )
          ],
        ),
      ),
    );
  }
}
