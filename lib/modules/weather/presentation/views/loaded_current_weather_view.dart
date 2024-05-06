import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/modules/weather/presentation/widgets/current_weather_display.dart';
import 'package:cloudwalk/modules/weather/presentation/widgets/last_update_display.dart';
import 'package:cloudwalk/modules/weather/presentation/widgets/weather_forecast_display.dart';
import 'package:cloudwalk/shared/components/layouts/orientation_layout_builder.dart';
import 'package:cloudwalk/shared/components/layouts/responsive_layout_builder.dart';
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
    final lastUpdate = currentWeather.lastUpdate;

    final verticalChildren = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LastWeatherUpdateDisplay(
          lastUpdate: lastUpdate,
        ),
        Expanded(
          flex: 2,
          child: CurrentTemperatureDisplay(
            currentWeatherEntity: currentWeather,
          ),
        ),
        Center(
          child: WeatherForecastDisplay(
            scrollDirection: Axis.horizontal,
            forecasts: forecasts,
          ),
        ),
      ],
    );

    final horizontalChildren = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LastWeatherUpdateDisplay(
          lastUpdate: lastUpdate,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: CurrentTemperatureDisplay(
                  currentWeatherEntity: currentWeather,
                ),
              ),
              Expanded(
                child: WeatherForecastDisplay(
                  scrollDirection: Axis.vertical,
                  forecasts: forecasts,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return OrientationLayoutBuilder(
      verticalChild: ResponsiveLayoutBuilder(
        mobileChild: verticalChildren,
        tabletChild: horizontalChildren,
      ),
      horizontalChild: horizontalChildren,
    );
  }
}
