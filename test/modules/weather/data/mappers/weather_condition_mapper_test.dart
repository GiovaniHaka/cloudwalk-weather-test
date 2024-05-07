import 'package:cloudwalk/modules/weather/data/mappers/weather_condition_mapper.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../data_mocks.dart';


class MockWeatherConditionEntity extends Mock
    implements WeatherConditionEntity {}

void main() {
  group('$WeatherConditionMapper', () {
    final mapper = WeatherConditionMapper();

    test(
        'toEntity should convert WeatherConditionModel to WeatherConditionEntity',
        () {
      const model = WeatherConditionModel(
        id: 1,
        main: 'Clear',
        description: 'Clear sky',
        icon: '01d',
        iconUrl: 'iconUrl',
      );

      const expectedEntity = WeatherConditionEntity(
        id: 1,
        main: 'Clear',
        description: 'Clear sky',
        icon: '01d',
        iconUrl: 'iconUrl',
      );

      final entity = mapper.toEntity(model);

      expect(entity, expectedEntity);
    });

    test('toEntity should throw MapperFailure if an error occurs', () {
      final model = MockWeatherConditionModel();

      expect(
        () => mapper.toEntity(model),
        throwsA(isA<MapperFailure>()),
      );
    });

    test('toModel should throw UnimplementedError', () {
      final entity = MockWeatherConditionEntity();

      expect(
        () => mapper.toModel(entity),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
