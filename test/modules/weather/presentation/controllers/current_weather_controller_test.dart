import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/modules/weather/presentation/controllers/current_weather_controller.dart';
import 'package:cloudwalk/shared/commons/failures/presentation_failures/controller_failure.dart';
import 'package:cloudwalk/shared/commons/states/app_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/domain_mocks.dart';

void main() {
  late CurrentWeatherController controller;
  late MockGetCurrentWeatherUsecase mockGetCurrentWeatherUsecase;
  late MockGetWeatherForecastUsecase mockGetWeatherForecastUsecase;

  late double lat;
  late double lon;

  late ConcertEntity concert;

  setUpAll(() {
    mockGetCurrentWeatherUsecase = MockGetCurrentWeatherUsecase();
    mockGetWeatherForecastUsecase = MockGetWeatherForecastUsecase();

    controller = CurrentWeatherController(
      getCurrentWeatherUsecase: mockGetCurrentWeatherUsecase,
      getWeatherForecastUsecase: mockGetWeatherForecastUsecase,
    );

    lat = 1;
    lon = 1;

    concert = ConcertEntity(
      id: 1,
      city: 'city',
      countryCode: 'countryCode',
      lat: lat,
      lon: lon,
    );
  });

  group('$CurrentWeatherController', () {
    test('initialize should set current weather and forecasts', () async {
      /// Arrange

      final currentWeatherEntity = MockCurrentWeatherEntity();
      final weatherForecastEntities = [MockWeatherForecastEntity()];

      controller.initialize();

      controller.onChangeConcert(concert);

      when(
        () => controller.getCurrentWeather(lat: lat, lon: lon),
      ).thenAnswer((_) async {});

      when(
        () => controller.getWeatherForecast(lat: lat, lon: lon),
      ).thenAnswer((_) async {});

      when(
        () => mockGetCurrentWeatherUsecase.call(lat: lat, lon: lon),
      ).thenAnswer((_) async => Right(currentWeatherEntity));

      when(
        () => mockGetWeatherForecastUsecase(lat: lat, lon: lon),
      ).thenAnswer((_) async => Right(weatherForecastEntities));

      /// Act
      await controller.initialize();

      // Assert
      expect(controller.currentWeather, isA<Loaded<CurrentWeatherEntity>>());
      expect(controller.forecasts, isA<Loaded<List<WeatherForecastEntity>>>());
    });

    test('initialize should set current weather to Empty when concert is null',
        () async {
      // Arrange
      await controller.onChangeConcert(null);

      // Act
      await controller.initialize();

      // Assert
      expect(controller.currentWeather, isA<Empty<CurrentWeatherEntity>>());
      expect(controller.forecasts, isA<Empty<List<WeatherForecastEntity>>>());
    });

    test(
        'initialize should set current weather to Error when getCurrentWeatherUsecase fails',
        () async {
      // Arrange
      final failure = ControllerFailure();
      final mockWeatherForecastEntity = MockWeatherForecastEntity();

      controller.onChangeConcert(concert);

      when(
        () => mockGetCurrentWeatherUsecase(lat: lat, lon: lon),
      ).thenAnswer((_) async => Left(failure));

      when(
        () => mockGetWeatherForecastUsecase(lat: lat, lon: lon),
      ).thenAnswer((_) async => Right([mockWeatherForecastEntity]));

      controller.onChangeConcert(concert);

      // Act
      await controller.initialize();

      // Assert
      expect(controller.currentWeather, isA<Error<CurrentWeatherEntity>>());
      expect(controller.forecasts, isA<Loaded<List<WeatherForecastEntity>>>());
    });

    test(
        'initialize should set forecasts to Error when getWeatherForecastUsecase fails',
        () async {
      final currentWeatherEntity = MockCurrentWeatherEntity();
      final failure = ControllerFailure();

      controller.onChangeConcert(concert);

      when(
        () => mockGetCurrentWeatherUsecase(lat: lat, lon: lon),
      ).thenAnswer((_) async => Right(currentWeatherEntity));

      when(
        () => mockGetWeatherForecastUsecase(lat: lat, lon: lon),
      ).thenAnswer((_) async => Left(failure));

      controller.onChangeConcert(concert);

      // Act
      await controller.initialize();

      // Assert
      expect(controller.currentWeather, isA<Loaded<CurrentWeatherEntity>>());
      expect(controller.forecasts, isA<Error<List<WeatherForecastEntity>>>());
    });
  });
}
