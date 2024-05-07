import 'package:cloudwalk/modules/weather/domain/entities/weather_condition_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';
import 'package:cloudwalk/modules/weather/domain/usecases/get_weather_forecast_usecase.dart';
import 'package:cloudwalk/shared/commons/extensions/either_extensions.dart';
import 'package:cloudwalk/shared/commons/failures/domain_failures/usecase_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../domain_mocks.dart';

void main() {
  late GetWeatherForecastUsecase usecase;
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
    usecase = GetWeatherForecastUsecaseImpl(repository: mockRepository);
  });

  group('GetWeatherForecastUsecase', () {
    const lat = 37.7749;
    const lon = -122.4194;

    test('should return a list of WeatherForecastEntity on success', () async {
      // Arrange
      final forecasts = [
        MockWeatherForecastEntity(),
        MockWeatherForecastEntity(),
      ];

      when(
        () => mockRepository.getWeatherForecast(lat: lat, lon: lon),
      ).thenAnswer((_) async => Right(forecasts));

      // Act
      final result = await usecase.call(lat: lat, lon: lon);

      // Assert
      expect(result, Right(forecasts));

      verify(
        () => mockRepository.getWeatherForecast(lat: lat, lon: lon),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });

    test('should remove current day forecast from the list', () async {
      // Arrange
      final now = DateTime.now();

      final todayForecast = WeatherForecastEntity(
        date: now,
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
          humidity: 0,
          temperature: 0,
          maxTemperature: 0,
          minTemperature: 0,
        ),
      );

      final tomorrowForecast = WeatherForecastEntity(
        date: now.add(const Duration(days: 1)),
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
          humidity: 0,
          temperature: 0,
          maxTemperature: 0,
          minTemperature: 0,
        ),
      );

      final forecasts = [
        todayForecast,
        tomorrowForecast,
      ];

      final expectedForecasts = [
        tomorrowForecast,
      ];

      when(
        () => mockRepository.getWeatherForecast(
          lat: lat,
          lon: lon,
        ),
      ).thenAnswer((_) async => Right(forecasts));

      // Act
      final result = await usecase.call(
        lat: lat,
        lon: lon,
      );

      // Assert
      expect(result.toRight(), expectedForecasts);

      verify(
        () => mockRepository.getWeatherForecast(
          lat: lat,
          lon: lon,
        ),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });

    test('should return null if forecasts is null', () async {
      // Arrange
      when(
        () => mockRepository.getWeatherForecast(lat: lat, lon: lon),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase.call(lat: lat, lon: lon);

      // Assert
      expect(result, const Right(null));

      verify(
        () => mockRepository.getWeatherForecast(lat: lat, lon: lon),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a UsecaseFailure on repository failure', () async {
      final failure = UsecaseFailure();

      when(
        () => mockRepository.getWeatherForecast(lat: lat, lon: lon),
      ).thenAnswer((_) async => Left(failure));

      final result = await usecase.call(lat: lat, lon: lon);

      expect(result, Left(failure));

      verify(
        () => mockRepository.getWeatherForecast(lat: lat, lon: lon),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a UsecaseFailure on exception', () async {
      // Arrange
      final exception = Exception();

      when(
        () => mockRepository.getWeatherForecast(lat: lat, lon: lon),
      ).thenThrow(exception);

      // Act
      final result = await usecase.call(lat: lat, lon: lon);

      // Assert
      expect(
        result.toLeft(),
        isA<UsecaseFailure>(),
      );

      verify(
        () => mockRepository.getWeatherForecast(lat: lat, lon: lon),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });
  });
}
