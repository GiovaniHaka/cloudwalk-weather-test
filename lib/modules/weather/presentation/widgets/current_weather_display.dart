import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/shared/commons/extensions/double_extension.dart';
import 'package:cloudwalk/shared/commons/extensions/string_extensions.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/components/images/app_network_image.dart';
import 'package:cloudwalk/shared/components/separators/vertical_separator.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
import 'package:flutter/material.dart';

/// [CurrentTemperatureDisplay] is a widget that displays the current weather.
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
        AppNetworkImage(
          imageUrl: weather.iconUrl,
          color: Colors.black,
        ),
        Text(
          main.temperatureWithUnits,
          style: AppTextStyle.headlineLarge(),
        ),
        const VerticalSeparator.small(),
        RichText(
          text: TextSpan(
            style: AppTextStyle.titleMedium(),
            children: [
              TextSpan(
                text: main.maxTemperature.toTemperature(),
              ),
              const TextSpan(text: ' / '),
              TextSpan(
                text: main.minTemperature.toTemperature(),
                style: AppTextStyle.bodyLarge(),
              ),
            ],
          ),
        ),
        const VerticalSeparator.small(),
        Text(
          '${Language.instance.lang.now} - ${weather.description.capitalize()}',
          style: AppTextStyle.titleSmall(),
        ),
      ],
    );
  }
}
