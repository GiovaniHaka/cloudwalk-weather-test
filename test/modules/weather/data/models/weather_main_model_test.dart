import 'package:flutter_test/flutter_test.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';

void main() {
  group('$WeatherMainModel', () {
    test('should convert WeatherMainModel to local JSON map', () {
      const model = WeatherMainModel(
        temperature: 25.0,
        maxTemperature: 30.0,
        minTemperature: 20.0,
        humidity: 80.0,
      );

      final json = model.toLocalMap();

      final expectedJson = {
        'temperature': 25.0,
        'maxTemperature': 30.0,
        'minTemperature': 20.0,
        'humidity': 80.0,
      };

      expect(json, expectedJson);
    });
  });
}
