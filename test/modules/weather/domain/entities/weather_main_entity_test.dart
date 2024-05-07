import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeatherMainEntity', () {
    test('temperatureWithUnits should return temperature with units', () {
      const weatherMain = WeatherMainEntity(
        temperature: 25.0,
        maxTemperature: 30.0,
        minTemperature: 20.0,
        humidity: 80.0,
      );

      expect(weatherMain.temperatureWithUnits, '25°C');
    });

    test('maxTemperatureWithUnits should return max temperature with units',
        () {
      const weatherMain = WeatherMainEntity(
        temperature: 25.0,
        maxTemperature: 30.0,
        minTemperature: 20.0,
        humidity: 80.0,
      );

      expect(weatherMain.maxTemperatureWithUnits, '30°C');
    });

    test('minTemperatureWithUnits should return min temperature with units',
        () {
      const weatherMain = WeatherMainEntity(
        temperature: 25.0,
        maxTemperature: 30.0,
        minTemperature: 20.0,
        humidity: 80.0,
      );

      expect(weatherMain.minTemperatureWithUnits, '20°C');
    });
  });
}
