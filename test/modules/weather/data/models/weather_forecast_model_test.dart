import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';

void main() {
  group('$WeatherForecastModel', () {
    test('should convert WeatherForecastModel to local JSON map', () {
      final model = WeatherForecastModel(
        date: DateTime.parse('2022-01-01T12:00:00.000Z'),
        conditions: const [
          WeatherConditionModel(
            id: 1,
            description: 'description',
            icon: 'icon',
            iconUrl: 'iconUrl',
            main: 'main',
          ),
        ],
        main: const WeatherMainModel(
          humidity: 1,
          temperature: 1,
          maxTemperature: 1,
          minTemperature: 1,
        ),
      );

      final json = model.toLocalMap();

      final expectedJson = {
        'date': '2022-01-01T12:00:00.000Z',
        'conditions': [
          {
            'id': 1,
            'description': 'description',
            'icon': 'icon',
            'main': 'main',
          }
        ],
        'main': {
          'humidity': 1,
          'temperature': 1,
          'maxTemperature': 1,
          'minTemperature': 1,
        },
      };

      expect(json, expectedJson);
    });
  });
}
