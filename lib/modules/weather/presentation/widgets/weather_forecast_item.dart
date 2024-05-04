import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/constants/radius_constants.dart';
import 'package:cloudwalk/shared/commons/extensions/datetime_extension.dart';
import 'package:cloudwalk/shared/commons/extensions/double_extension.dart';
import 'package:cloudwalk/shared/commons/extensions/string_extensions.dart';
import 'package:cloudwalk/shared/commons/styles/app_colors.dart';
import 'package:cloudwalk/shared/commons/styles/app_text_style.dart';
import 'package:cloudwalk/shared/components/images/app_network_image.dart';
import 'package:flutter/material.dart';

import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';

class WeatherForecastItem extends StatefulWidget {
  final DateTime date;
  final List<WeatherForecastEntity> forecasts;

  const WeatherForecastItem({
    Key? key,
    required this.date,
    required this.forecasts,
  }) : super(key: key);

  @override
  State<WeatherForecastItem> createState() => _WeatherForecastItemState();
}

class _WeatherForecastItemState extends State<WeatherForecastItem> {
  late DateTime date;
  late double maxTemperature;
  late double minTemperature;
  late String description;
  late String iconUrl;

  setup() {
    date = widget.date;

    maxTemperature = widget.forecasts.map((e) => e.main.maxTemperature).reduce(
          (value, element) => value > element ? value : element,
        );

    minTemperature = widget.forecasts.map((e) => e.main.minTemperature).reduce(
          (value, element) => value < element ? value : element,
        );

    final middleIndex = widget.forecasts.length ~/ 2;

    final firstForecast = widget.forecasts[middleIndex];
    final firstWeather = firstForecast.conditions.first;

    description = firstWeather.description;
    iconUrl = firstWeather.iconUrl;
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  void didUpdateWidget(covariant WeatherForecastItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.primaryRegular.withOpacity(0.13),
        borderRadius: BorderRadius.circular(
          regularRadius,
        ),
      ),
      padding: const EdgeInsets.all(regularPadding),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          AppNetworkImage(
            imageUrl: iconUrl,
            height: 40,
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date.formatWeekday().capitalize(),
                style: AppTextStyle.titleMedium(),
                overflow: TextOverflow.ellipsis,
              ),
              RichText(
                text: TextSpan(
                  style: AppTextStyle.titleSmall(),
                  children: [
                    TextSpan(
                      text: maxTemperature.toTemperature(),
                    ),
                    const TextSpan(text: ' / '),
                    TextSpan(
                      text: minTemperature.toTemperature(),
                      style: AppTextStyle.bodyMedium(),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                description.capitalize(),
                style: AppTextStyle.bodyMedium(),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
