import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$WeatherConditionModel', () {
    test('toLocalMap should return correct map', () {
      final model = WeatherConditionModel(
        id: 800,
        main: 'Clear',
        description: 'clear sky',
        icon: '01d',
        iconUrl: WeatherConditionModel.getIconUrl('01d'),
      );

      final expected = {
        'id': model.id,
        'main': model.main,
        'description': model.description,
        'icon': model.icon,
      };

      final result = model.toLocalMap();

      expect(result, expected);
    });
  });
}
