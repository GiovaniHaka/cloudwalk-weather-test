import 'package:cloudwalk/core/endpoints/app_endpoints.dart';
import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';
import 'package:cloudwalk/modules/weather/data/sources/remote/remote_weather_source_impl.dart';
import 'package:cloudwalk/shared/commons/extensions/either_extensions.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/source_failure.dart';
import 'package:cloudwalk/shared/services/api_client/api_client_service.dart';
import 'package:cloudwalk/shared/services/env/env.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../shared/services/locale/locace_mocks.dart';
import '../../data_mocks.dart';

class MockApiClientService extends Mock implements ApiClientService {}

class MockAppEndpoints extends Mock implements AppEndpoints {}

class MockEnv extends Mock implements Env {}

class MockResponse extends Mock implements Response {}

void main() {
  late RemoteWeatherSourceImpl remoteWeatherSource;
  late MockApiClientService mockApiClientService;
  late MockAppEndpoints mockAppEndpoints;
  late MockEnv mockEnv;
  late MockCurrentWeatherMapper mockCurrentWeatherMapper;
  late MockWeatherForecastMapper mockWeatherForecastMapper;
  late MockCurrentWeatherModel mockCurrerntWeatherModel;
  late MockResponse mockResponse;
  late MockLocaleService mockLocaleService;

  setUp(() {
    mockApiClientService = MockApiClientService();
    mockAppEndpoints = MockAppEndpoints();
    mockEnv = MockEnv();
    mockCurrentWeatherMapper = MockCurrentWeatherMapper();
    mockWeatherForecastMapper = MockWeatherForecastMapper();
    mockCurrerntWeatherModel = MockCurrentWeatherModel();
    mockResponse = MockResponse();
    mockLocaleService = MockLocaleService();

    remoteWeatherSource = RemoteWeatherSourceImpl(
      apiClientService: mockApiClientService,
      endpoints: mockAppEndpoints,
      env: mockEnv,
      currentWeatherMapper: mockCurrentWeatherMapper,
      weatherForecastMapper: mockWeatherForecastMapper,
      localeService: mockLocaleService,
    );
  });

  group('$RemoteWeatherSourceImpl getCurrentWeather', () {
    test('should return CurrentWeatherModel on successful API call', () async {
      // Arrange
      const double lat = 1;
      const double lon = 1;

      when(
        () => mockLocaleService.getCurrentLocale(),
      ).thenReturn('pt_BR');

      when(
        () => mockEnv.openWeatherApiKey,
      ).thenReturn('YOUR_API_KEY');

      when(
        () => mockAppEndpoints.currentWeather,
      ).thenReturn('currentWeather');

      when(
        () => mockApiClientService.get(
          path: any(named: 'path'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => mockResponse);

      when(
        () => mockResponse.data,
      ).thenReturn({});

      when(
        () => mockCurrentWeatherMapper.fromRemoteJson(any(), any()),
      ).thenReturn(mockCurrerntWeatherModel);

      // Act
      final result = await remoteWeatherSource.getCurrentWeather(
        lat: lat,
        lon: lon,
      );

      // Assert
      expect(result.toRight(), isA<CurrentWeatherModel>());

      verify(
        () => mockCurrentWeatherMapper.fromRemoteJson(any(), any()),
      ).called(1);

      verify(
        () => mockResponse.data,
      ).called(1);
    });

    test('should return Left on failed API call', () async {
      // Arrange
      const double lat = 1;
      const double lon = 1;

      when(
        () => mockLocaleService.getCurrentLocale(),
      ).thenReturn('pt_BR');

      when(
        () => mockEnv.openWeatherApiKey,
      ).thenReturn('YOUR_API_KEY');

      when(
        () => mockAppEndpoints.currentWeather,
      ).thenReturn('currentWeather');

      when(
        () => mockApiClientService.get(
          path: any(named: 'path'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(Exception());

      // Act
      final result = await remoteWeatherSource.getCurrentWeather(
        lat: lat,
        lon: lon,
      );

      // Assert
      expect(result.toLeft(), isA<SourceFailure>());

      verify(
        () => mockApiClientService.get(
          path: any(named: 'path'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);

      verifyNever(
        () => mockCurrentWeatherMapper.fromRemoteJson(any(), any()),
      );

      verifyNever(
        () => mockResponse.data,
      );
    });
  });

  group('$RemoteWeatherSourceImpl getWeatherForecast', () {
    test('should return List<WeatherForecastModel> on successful API call',
        () async {
      // Arrange
      const double lat = 1;
      const double lon = 1;

      when(
        () => mockLocaleService.getCurrentLocale(),
      ).thenReturn('pt_BR');

      when(
        () => mockEnv.openWeatherApiKey,
      ).thenReturn('YOUR_API_KEY');

      when(
        () => mockAppEndpoints.weatherForecast,
      ).thenReturn('weatherForecast');

      when(
        () => mockApiClientService.get(
          path: any(named: 'path'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => mockResponse);

      when(
        () => mockResponse.data,
      ).thenReturn({
        'list': [],
      });

      when(
        () => mockWeatherForecastMapper.fromRemoteJson(any()),
      ).thenReturn(MockWeatherForecastModel());

      // Act
      final result = await remoteWeatherSource.getWeatherForecast(
        lat: lat,
        lon: lon,
      );

      // Assert
      expect(result.toRight(), isA<List<WeatherForecastModel>>());

      verify(
        () => mockResponse.data,
      ).called(1);

      verify(
        () => mockApiClientService.get(
          path: any(named: 'path'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('should return Left on failed API call', () async {
      // Arrange
      const double lat = 1;
      const double lon = 1;

      when(
        () => mockLocaleService.getCurrentLocale(),
      ).thenReturn('pt_BR');

      when(
        () => mockEnv.openWeatherApiKey,
      ).thenReturn('YOUR_API_KEY');

      when(
        () => mockAppEndpoints.weatherForecast,
      ).thenReturn('weatherForecast');

      when(
        () => mockApiClientService.get(
          path: any(named: 'path'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(Exception());

      // Act
      final result = await remoteWeatherSource.getWeatherForecast(
        lat: lat,
        lon: lon,
      );

      // Assert
      expect(result.toLeft(), isA<SourceFailure>());

      verify(
        () => mockApiClientService.get(
          path: any(named: 'path'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);

      verifyNever(
        () => mockWeatherForecastMapper.fromRemoteJson(any()),
      );

      verifyNever(
        () => mockResponse.data,
      );
    });
  });
}
