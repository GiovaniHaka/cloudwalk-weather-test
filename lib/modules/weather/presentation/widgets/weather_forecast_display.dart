import 'package:cloudwalk/modules/weather/presentation/widgets/weather_forecast_item.dart';
import 'package:cloudwalk/shared/commons/constants/padding_constants.dart';
import 'package:cloudwalk/shared/commons/extensions/datetime_extension.dart';
import 'package:cloudwalk/shared/components/separators/horizontal_separator.dart';
import 'package:cloudwalk/shared/components/separators/vertical_separator.dart';
import 'package:flutter/material.dart';

import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';

class WeatherForecastDisplay extends StatefulWidget {
  final Axis scrollDirection;
  final List<WeatherForecastEntity> forecasts;

  const WeatherForecastDisplay({
    Key? key,
    required this.forecasts,
    this.scrollDirection = Axis.horizontal,
  }) : super(key: key);

  @override
  State<WeatherForecastDisplay> createState() => _WeatherForecastDisplayState();
}

class _WeatherForecastDisplayState extends State<WeatherForecastDisplay> {
  late Axis scrollDirection;
  double? listHeight;
  double? itemWidth;

  Map<DateTime, List<WeatherForecastEntity>> _groupedForecasts = {};

  setupGrouped() {
    _groupedForecasts = {};

    for (final forecast in widget.forecasts) {
      final date = forecast.date?.withoutTime();

      if (date == null) {
        continue;
      }

      if (_groupedForecasts.containsKey(date)) {
        _groupedForecasts[date]?.add(forecast);
        continue;
      }

      _groupedForecasts[date] = [forecast];
    }

    final now = DateTime.now().withoutTime();
    _groupedForecasts.removeWhere((key, value) => key.isAtSameMomentAs(now));
  }

  setupUiParams() {
    scrollDirection = widget.scrollDirection;
    final isVertical = scrollDirection == Axis.vertical;

    if (isVertical) {
      listHeight = null;
      itemWidth = null;
      return;
    }

    listHeight = 150;
    itemWidth = 150;
  }

  @override
  void initState() {
    super.initState();
    setupGrouped();
    setupUiParams();
  }

  @override
  void didUpdateWidget(covariant WeatherForecastDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    setupGrouped();
  }

  @override
  Widget build(BuildContext context) {
    final isVertical = scrollDirection == Axis.vertical;

    return SizedBox(
      height: listHeight,
      child: ListView.separated(
        padding: const EdgeInsets.all(viewPadding),
        scrollDirection: scrollDirection,
        itemCount: _groupedForecasts.length,
        itemBuilder: (context, index) {
          final date = _groupedForecasts.keys.elementAt(index);
          final forecasts = _groupedForecasts[date];

          return WeatherForecastItem(
            date: date,
            forecasts: forecasts ?? [],
            width: itemWidth,
          );
        },
        separatorBuilder: (context, index) {
          if (isVertical) {
            return const VerticalSeparator.small();
          }

          return const HorizontalSeparator.small();
        },
      ),
    );
  }
}
