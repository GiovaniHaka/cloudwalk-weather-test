import 'package:cloudwalk/modules/weather/data/mappers/weather_main_mapper.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherMainEntity extends Mock implements WeatherMainEntity {}

class MockWeatherMainModel extends Mock implements WeatherMainModel {}

void main() {
  group('$WeatherMainMapper', () {
    final mapper = WeatherMainMapper();

    test('toEntity() should convert WeatherMainModel to WeatherMainEntity', () {
      const model = WeatherMainModel(
        humidity: 80,
        maxTemperature: 30,
        minTemperature: 20,
        temperature: 25,
      );

      final entity = mapper.toEntity(model);

      const expectedEntity = WeatherMainEntity(
        humidity: 80,
        maxTemperature: 30,
        minTemperature: 20,
        temperature: 25,
      );

      expect(entity, expectedEntity);
    });

    test('fromRemoteJson() should convert json to WeatherMainModel', () {
      final json = {
        'temp': 25.0,
        'feels_like': 25.0,
        'temp_min': 20.0,
        'temp_max': 30.0,
        'pressure': 1010,
        'humidity': 80,
      };

      final model = mapper.fromRemoteJson(json);

      const expectedModel = WeatherMainModel(
        temperature: 25.0,
        humidity: 80,
        maxTemperature: 30.0,
        minTemperature: 20.0,
      );

      expect(model, expectedModel);
    });

    test('fromLocalJson() should convert json to WeatherMainModel', () {
      final json = {
        'temperature': 25.0,
        'minTemperature': 20.0,
        'maxTemperature': 30.0,
        'humidity': 80.0,
      };

      final model = mapper.fromLocalJson(json);

      const expectedModel = WeatherMainModel(
        temperature: 25.0,
        humidity: 80.0,
        maxTemperature: 30.0,
        minTemperature: 20.0,
      );

      expect(model, expectedModel);
    });

    test('toEntity() should throw MapperFailure when conversion fails', () {
      expect(
        () => mapper.toEntity(MockWeatherMainModel()),
        throwsA(isA<MapperFailure>()),
      );
    });

    test(
        'toModel() should throw UnimplementedError when converting from entity to model',
        () {
      expect(
        () => mapper.toModel(MockWeatherMainEntity()),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
