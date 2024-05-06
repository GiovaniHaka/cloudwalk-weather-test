import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk/modules/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:cloudwalk/shared/commons/extensions/either_extensions.dart';
import 'package:cloudwalk/shared/commons/failures/domain_failures/usecase_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockCurrentWeatherEntity extends Mock implements CurrentWeatherEntity {}

void main() {
  late GetCurrentWeatherUsecase usecase;
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
    usecase = GetCurrentWeatherUsecaseImpl(repository: mockRepository);
  });

  group('GetCurrentWeatherUsecase', () {
    const lat = 37.7749;
    const lon = -122.4194;

    test('should return CurrentWeatherEntity when repository call succeeds',
        () async {
      final entity = MockCurrentWeatherEntity();

      final expected = Right(entity);

      when(
        () => mockRepository.getCurrentWeather(
          lat: lat,
          lon: lon,
        ),
      ).thenAnswer((_) async => Right(entity));

      final result = await usecase.call(lat: lat, lon: lon);

      expect(result, expected);

      verify(
        () => mockRepository.getCurrentWeather(lat: lat, lon: lon),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when repository return Left', () async {
      final failure = Failure();

      final expected = Left(failure);

      when(
        () => mockRepository.getCurrentWeather(
          lat: lat,
          lon: lon,
        ),
      ).thenAnswer((_) async => Left(failure));

      final result = await usecase.call(lat: lat, lon: lon);

      expect(result, expected);

      verify(
        () => mockRepository.getCurrentWeather(lat: lat, lon: lon),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when repository call fails', () async {
      when(() => mockRepository.getCurrentWeather(
            lat: lat,
            lon: lon,
          )).thenThrow(Exception());

      final result = await usecase.call(
        lat: lat,
        lon: lon,
      );

      expect(result.toLeft(), isA<UsecaseFailure>());

      verify(
        () => mockRepository.getCurrentWeather(lat: lat, lon: lon),
      ).called(1);

      verifyNoMoreInteractions(mockRepository);
    });
  });
}
