import 'package:cloudwalk/modules/weather/data/mappers/weather_condition_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_forecast_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_main_mapper.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../domain/domain_mocks.dart';


void main() {
  late WeatherForecastMapper mapper;
  late DateTime date;

  setUpAll(() {
    mapper = WeatherForecastMapper(
      weatherConditionMapper: WeatherConditionMapper(),
      weatherMainMapper: WeatherMainMapper(),
    );

    date = DateTime.now();
  });

  group('$WeatherForecastEntity', () {
    test('toEntity() correctly converts model to entity', () {
      final model = WeatherForecastModel(
        date: date,
        conditions: const [
          WeatherConditionModel(
            id: 500,
            main: 'Rain',
            description: 'chuva leve',
            icon: '10d',
            iconUrl: 'https://openweathermap.org/img/wn/10d@4x.png',
          ),
        ],
        main: const WeatherMainModel(
          temperature: 15.5,
          minTemperature: 13.32,
          maxTemperature: 17.11,
          humidity: 80,
        ),
      );

      final result = mapper.toEntity(model);

      final expectedEntity = WeatherForecastEntity(
        date: date,
        conditions: const [
          WeatherConditionEntity(
              id: 500,
              main: 'Rain',
              description: 'chuva leve',
              icon: '10d',
              iconUrl: 'https://openweathermap.org/img/wn/10d@4x.png'),
        ],
        main: const WeatherMainEntity(
          temperature: 15.5,
          minTemperature: 13.32,
          maxTemperature: 17.11,
          humidity: 80,
        ),
      );

      expect(result, expectedEntity);
    });

    test('fromRemoteJson() correctly converts json to model', () {
      final json = {
        'dt_txt': date.toIso8601String(),
        'weather': [
          {
            'id': 1,
            'main': 'main',
            'description': 'description',
            'icon': 'icon',
          },
        ],
        'main': {
          'temp': 15.5,
          'temp_min': 13.32,
          'temp_max': 17.11,
          'humidity': 80,
        },
      };

      final result = mapper.fromRemoteJson(json);

      final expectedModel = WeatherForecastModel(
        date: date,
        conditions: const [
          WeatherConditionModel(
            id: 1,
            main: 'main',
            description: 'description',
            icon: 'icon',
            iconUrl: 'https://openweathermap.org/img/wn/icon@4x.png',
          ),
        ],
        main: const WeatherMainModel(
          temperature: 15.5,
          minTemperature: 13.32,
          maxTemperature: 17.11,
          humidity: 80,
        ),
      );

      expect(result, expectedModel);
    });

    test('fromLocalJson() correctly converts json to model', () {
      final json = {
        'date': date.toIso8601String(),
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

      final result = mapper.fromLocalJson(json);

      final expectedModel = WeatherForecastModel(
        date: date,
        conditions: const [
          WeatherConditionModel(
            id: 1,
            main: 'main',
            description: 'description',
            icon: 'icon',
            iconUrl: 'https://openweathermap.org/img/wn/icon@4x.png',
          ),
        ],
        main: const WeatherMainModel(
          temperature: 15.5,
          minTemperature: 13.32,
          maxTemperature: 17.11,
          humidity: 80,
        ),
      );

      expect(result, expectedModel);
    });

    test('toModel() throws UnimplementedError', () {
      expect(
        () => mapper.toModel(MockWeatherForecastEntity()),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
