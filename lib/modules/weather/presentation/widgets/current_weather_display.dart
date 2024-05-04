import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/shared/commons/extensions/string_extensions.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/components/separators/vertical_separator.dart';
import 'package:flutter/material.dart';

class CurrentTemperatureDisplay extends StatelessWidget {
  final CurrentWeatherEntity currentWeatherEntity;

  const CurrentTemperatureDisplay({
    Key? key,
    required this.currentWeatherEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final main = currentWeatherEntity.main;
    final weather = currentWeatherEntity.conditions.first;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          main.temperatureWithUnits,
          style: AppTextStyle.headlineMedium(),
        ),
        const VerticalSeparator.small(),
        RichText(
          text: TextSpan(
            style: AppTextStyle.titleMedium(),
            children: [
              TextSpan(text: main.minTemperatureWithUnits),
              const TextSpan(text: ' - '),
              TextSpan(text: main.maxTemperatureWithUnits),
            ],
          ),
        ),
        const VerticalSeparator.small(),
        Text(
          weather.description.capitalize(),
          style: AppTextStyle.titleSmall(),
        ),
      ],
    );
  }
}
