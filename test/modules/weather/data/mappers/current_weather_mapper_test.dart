import 'package:cloudwalk/modules/weather/data/mappers/current_weather_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_condition_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_main_mapper.dart';
import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrentWeatherEntity extends Mock implements CurrentWeatherEntity {}

class MockCurrentWeatherModel extends Mock implements CurrentWeatherModel {}

void main() {
  late CurrentWeatherMapper mapper;

  setUpAll(() {
    mapper = CurrentWeatherMapper(
      weatherConditionMapper: WeatherConditionMapper(),
      weatherMainMapper: WeatherMainMapper(),
    );
  });

  group('$CurrentWeatherMapper', () {
    test('toEntity should convert CurrentWeatherModel to CurrentWeatherEntity',
        () {
      final model = CurrentWeatherModel(
        lastUpdate: DateTime.now(),
        conditions: const [
          WeatherConditionModel(
            id: 1,
            main: 'main',
            description: 'description',
            icon: 'icon',
            iconUrl: 'iconUrl',
          ),
        ],
        main: const WeatherMainModel(
          temperature: 25.0,
          humidity: 80.0,
          maxTemperature: 30.0,
          minTemperature: 20.0,
        ),
      );

      final expectedEntity = CurrentWeatherEntity(
        lastUpdate: model.lastUpdate,
        conditions: const [
          WeatherConditionEntity(
            id: 1,
            main: 'main',
            description: 'description',
            icon: 'icon',
            iconUrl: 'iconUrl',
          ),
        ],
        main: const WeatherMainEntity(
          temperature: 25.0,
          humidity: 80.0,
          maxTemperature: 30.0,
          minTemperature: 20.0,
        ),
      );

      final entity = mapper.toEntity(model);

      expect(entity, expectedEntity);
    });

    test('toEntity should throw MapperFailure if an error occurs', () {
      expect(
        () => mapper.toEntity(MockCurrentWeatherModel()),
        throwsA(isA<MapperFailure>()),
      );
    });

    test('toModel should throw UnimplementedError', () {
      expect(
        () => mapper.toModel(MockCurrentWeatherEntity()),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
