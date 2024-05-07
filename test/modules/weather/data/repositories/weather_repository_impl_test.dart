import 'package:cloudwalk/modules/weather/data/repositories/weather_repository_impl.dart';
import 'package:cloudwalk/shared/commons/extensions/either_extensions.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/repository_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared/services/connectivity/connectivity_mocks.dart';
import '../../domain/domain_mocks.dart';
import '../data_mocks.dart';

void main() {
  group('$WeatherRepositoryImpl', () {
    late WeatherRepositoryImpl repository;
    late MockRemoteWeatherSource mockRemoteSource;
    late MockLocalWeatherSource mockLocalSource;
    late MockConnectivityService mockConnectivityService;
    late MockCurrentWeatherMapper mockCurrentWeatherMapper;
    late MockWeatherForecastMapper mockWeatherForecastMapper;

    setUpAll(() {
      mockRemoteSource = MockRemoteWeatherSource();
      mockLocalSource = MockLocalWeatherSource();
      mockConnectivityService = MockConnectivityService();
      mockCurrentWeatherMapper = MockCurrentWeatherMapper();
      mockWeatherForecastMapper = MockWeatherForecastMapper();

      repository = WeatherRepositoryImpl(
        remoteSource: mockRemoteSource,
        localSource: mockLocalSource,
        connectivityService: mockConnectivityService,
        currentWeatherMapper: mockCurrentWeatherMapper,
        weatherForecastMapper: mockWeatherForecastMapper,
      );
    });

    group('getCurrentWeather', () {
      test('should return current weather entity when online', () async {
        // Arrange
        const lat = 37.7749;
        const lon = -122.4194;

        final model = MockCurrentWeatherModel();
        final entity = MockCurrentWeatherEntity();

        when(() => mockConnectivityService.isOffline).thenReturn(false);

        when(
          () => mockRemoteSource.getCurrentWeather(lat: lat, lon: lon),
        ).thenAnswer((_) async => Right(model));

        when(
          () => mockCurrentWeatherMapper.toEntity(model),
        ).thenReturn(entity);

        // Act
        final result = await repository.getCurrentWeather(lat: lat, lon: lon);

        verify(
          () => mockRemoteSource.getCurrentWeather(lat: lat, lon: lon),
        ).called(1);

        verifyNever(
          () => mockLocalSource.getCurrentWeather(lat: lat, lon: lon),
        );

        verify(
          () => mockLocalSource.saveCurrentWeather(
            lat: lat,
            lon: lon,
            currentWeatherModel: model,
          ),
        ).called(1);

        verify(
          () => mockCurrentWeatherMapper.toEntity(model),
        ).called(1);

        // Assert
        expect(result, equals(Right(entity)));

        verifyNoMoreInteractions(mockRemoteSource);
      });

      test('should return current weather entity when offline', () async {
        // Arrange
        const lat = 37.7749;
        const lon = -122.4194;

        final model = MockCurrentWeatherModel();
        final entity = MockCurrentWeatherEntity();

        when(() => mockConnectivityService.isOffline).thenReturn(true);

        when(
          () => mockLocalSource.getCurrentWeather(lat: lat, lon: lon),
        ).thenAnswer(
          (_) async => Right(model),
        );

        when(
          () => mockCurrentWeatherMapper.toEntity(model),
        ).thenReturn(entity);

        // Act
        final result = await repository.getCurrentWeather(lat: lat, lon: lon);

        verifyNever(
          () => mockRemoteSource.getCurrentWeather(lat: lat, lon: lon),
        );

        verify(
          () => mockLocalSource.getCurrentWeather(lat: lat, lon: lon),
        ).called(1);

        verifyNever(
          () => mockLocalSource.saveCurrentWeather(
            lat: lat,
            lon: lon,
            currentWeatherModel: model,
          ),
        );

        verify(
          () => mockCurrentWeatherMapper.toEntity(model),
        ).called(1);

        // Assert
        expect(result, equals(Right(entity)));

        verifyNoMoreInteractions(mockLocalSource);
      });

      test('should return failure when an error occurs', () async {
        // Arrange
        const lat = 37.7749;
        const lon = -122.4194;

        when(() => mockConnectivityService.isOffline).thenReturn(false);

        when(
          () => mockRemoteSource.getCurrentWeather(lat: lat, lon: lon),
        ).thenThrow(Exception());

        // Act
        final result = await repository.getCurrentWeather(lat: lat, lon: lon);

        verify(
          () => mockRemoteSource.getCurrentWeather(lat: lat, lon: lon),
        ).called(1);

        // Assert
        expect(
          result.toLeft(),
          isA<RepositoryFailure>(),
        );

        verifyNoMoreInteractions(mockRemoteSource);
      });
    });

    group('getWeatherForecast', () {
      test('should return weather forecast entity when online', () async {
        // Arrange
        const lat = 37.7749;
        const lon = -122.4194;

        final model = MockWeatherForecastModel();
        final entity = MockWeatherForecastEntity();

        when(() => mockConnectivityService.isOffline).thenReturn(false);

        when(
          () => mockRemoteSource.getWeatherForecast(lat: lat, lon: lon),
        ).thenAnswer((_) async => Right([model]));

        when(
          () => mockWeatherForecastMapper.toEntity(model),
        ).thenReturn(entity);

        // Act
        final result = await repository.getWeatherForecast(lat: lat, lon: lon);

        verify(
          () => mockRemoteSource.getWeatherForecast(lat: lat, lon: lon),
        ).called(1);

        verifyNever(
          () => mockLocalSource.getWeatherForecast(lat: lat, lon: lon),
        );

        verify(
          () => mockLocalSource.saveWeatherForecast(
            lat: lat,
            lon: lon,
            weatherForecasts: [model],
          ),
        ).called(1);

        verify(
          () => mockWeatherForecastMapper.toEntity(model),
        ).called(1);

        // Assert
        expect(result.toRight(), equals([entity]));

        verifyNoMoreInteractions(mockRemoteSource);
      });

      test('should return weather forecast entity when offline', () async {
        // Arrange
        const lat = 37.7749;
        const lon = -122.4194;

        final model = MockWeatherForecastModel();
        final entity = MockWeatherForecastEntity();

        when(() => mockConnectivityService.isOffline).thenReturn(true);

        when(
          () => mockLocalSource.getWeatherForecast(lat: lat, lon: lon),
        ).thenAnswer((_) async => Right([model]));

        when(
          () => mockWeatherForecastMapper.toEntity(model),
        ).thenReturn(entity);

        // Act
        final result = await repository.getWeatherForecast(lat: lat, lon: lon);

        verifyNever(
          () => mockRemoteSource.getWeatherForecast(lat: lat, lon: lon),
        );

        verify(
          () => mockLocalSource.getWeatherForecast(lat: lat, lon: lon),
        ).called(1);

        verifyNever(
          () => mockLocalSource.saveWeatherForecast(
            lat: lat,
            lon: lon,
            weatherForecasts: [model],
          ),
        );

        verify(
          () => mockWeatherForecastMapper.toEntity(model),
        ).called(1);

        // Assert
        expect(result.toRight(), equals([entity]));
        verifyNoMoreInteractions(mockLocalSource);
      });

      test('should return failure when an error occurs', () async {
        // Arrange
        const lat = 37.7749;
        const lon = -122.4194;

        when(() => mockConnectivityService.isOffline).thenReturn(false);

        when(
          () => mockRemoteSource.getWeatherForecast(lat: lat, lon: lon),
        ).thenThrow(Exception());

        // Act
        final result = await repository.getWeatherForecast(lat: lat, lon: lon);

        verify(
          () => mockRemoteSource.getWeatherForecast(lat: lat, lon: lon),
        ).called(1);

        // Assert
        expect(result.toLeft(), isA<RepositoryFailure>());
        verifyNoMoreInteractions(mockRemoteSource);
      });
    });
  });
}
