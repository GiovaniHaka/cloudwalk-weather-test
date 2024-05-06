import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final lastUpdate = DateTime.now();

  group('$CurrentWeatherModel', () {
    test('toLocalMap() correctly converts model to map', () {
      final model = CurrentWeatherModel(
        conditions: const [
          WeatherConditionModel(
              id: 1,
              main: 'main',
              description: 'description',
              icon: 'icon',
              iconUrl: 'iconUrl'),
        ],
        main: const WeatherMainModel(
          temperature: 15.5,
          minTemperature: 13.32,
          maxTemperature: 17.11,
          humidity: 80,
        ),
        lastUpdate: lastUpdate,
      );

      final result = model.toLocalMap();

      final expected = {
        'lastUpdate': lastUpdate.toIso8601String(),
        'conditions': [
          {
            'id': 1,
            'main': 'main',
            'description': 'description',
            'icon': 'icon',
          },
        ],
        'main': {
          'temperature': 15.5,
          'minTemperature': 13.32,
          'maxTemperature': 17.11,
          'humidity': 80,
        },
      };

      expect(result, expected);
    });
  });
}
