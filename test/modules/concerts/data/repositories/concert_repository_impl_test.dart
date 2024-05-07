import 'package:cloudwalk/modules/concerts/data/mappers/concert_mapper.dart';
import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/modules/concerts/data/repositories/concert_repository_impl.dart';
import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/shared/commons/extensions/either_extensions.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/repository_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../weather/data/repositories/weather_repository_impl_test.dart';
import '../concert_data_mocks.dart';

void main() {
  late ConcertRepositoryImpl concertRepository;
  late MockRemoteConcertSource mockRemoteConcertSource;
  late MockLocalConcertSource mockLocalConcertSource;
  late MockConnectivityService mockConnectivityService;

  setUp(() {
    mockRemoteConcertSource = MockRemoteConcertSource();
    mockLocalConcertSource = MockLocalConcertSource();
    mockConnectivityService = MockConnectivityService();

    concertRepository = ConcertRepositoryImpl(
      remoteSource: mockRemoteConcertSource,
      localSource: mockLocalConcertSource,
      connectivityService: mockConnectivityService,
      concertMapper: ConcertMapper(),
    );
  });

  group('$ConcertRepositoryImpl getConcerts', () {
    test('should return concerts from local source when offline', () async {
      const searchCity = null;

      // Arrange
      when(
        () => mockConnectivityService.isOffline,
      ).thenReturn(true);

      when(
        () => mockLocalConcertSource.getConcerts(searchCity: searchCity),
      ).thenAnswer((_) async => const Right(allModels));

      // Act
      final result = await concertRepository.getConcerts(
        searchCity: searchCity,
      );

      // Assert
      expect(result.toRight(), allEntities);

      verify(
        () => mockLocalConcertSource.getConcerts(searchCity: searchCity),
      ).called(1);

      verifyNever(
        () => mockRemoteConcertSource.getConcerts(searchCity: searchCity),
      );
    });

    test('should return concerts from remote source when online', () async {
      const searchCity = null;

      // Arrange
      when(() => mockConnectivityService.isOffline).thenReturn(false);

      when(() => mockRemoteConcertSource.getConcerts(searchCity: searchCity))
          .thenAnswer(
        (_) async => const Right(allModels),
      );

      // Act
      final result = await concertRepository.getConcerts(
        searchCity: searchCity,
      );

      // Assert
      expect(result.toRight(), allEntities);

      verifyNever(
        () => mockLocalConcertSource.getConcerts(searchCity: searchCity),
      );

      verify(
        () => mockRemoteConcertSource.getConcerts(searchCity: searchCity),
      ).called(1);
    });

    test('should return filtered concerts from remote source when online',
        () async {
      const searchCity = 'Melbourne';

      // Arrange
      when(
        () => mockConnectivityService.isOffline,
      ).thenReturn(false);

      when(
        () => mockRemoteConcertSource.getConcerts(searchCity: searchCity),
      ).thenAnswer(
        (_) async => const Right(melbourneModels),
      );

      // Act
      final result = await concertRepository.getConcerts(
        searchCity: searchCity,
      );

      // Assert
      expect(result.toRight(), melbourneEntities);

      verifyNever(
        () => mockLocalConcertSource.getConcerts(searchCity: searchCity),
      );

      verify(
        () => mockRemoteConcertSource.getConcerts(searchCity: searchCity),
      ).called(1);
    });

    test('should return Left with RepositoryFailure on exception', () async {
      const searchCity = null;

      // Arrange
      when(
        () => mockConnectivityService.isOffline,
      ).thenReturn(false);

      when(
        () => mockRemoteConcertSource.getConcerts(searchCity: searchCity),
      ).thenThrow(Exception());

      // Act
      final result = await concertRepository.getConcerts(
        searchCity: searchCity,
      );

      // Assert
      expect(result.toLeft(), isA<RepositoryFailure>());

      verifyNever(
        () => mockLocalConcertSource.getConcerts(searchCity: searchCity),
      );

      verify(
        () => mockRemoteConcertSource.getConcerts(searchCity: searchCity),
      ).called(1);
    });
  });
}

const allModels = [
  ConcertModel(
    id: 1,
    city: 'Silverstone',
    countryCode: 'UK',
    lat: 52.0717,
    lon: -1.0193,
  ),
  ConcertModel(
    id: 2,
    city: 'São Paulo',
    countryCode: 'BR',
    lat: -23.5505199,
    lon: -46.6333094,
  ),
  ConcertModel(
    id: 3,
    city: 'Melbourne',
    countryCode: 'AU',
    lat: -37.8136,
    lon: 144.9631,
  ),
  ConcertModel(
    id: 4,
    city: 'Monte Carlo',
    countryCode: 'MC',
    lat: 43.7384,
    lon: 7.4246,
  ),
];

const allEntities = [
  ConcertEntity(
    id: 1,
    city: 'Silverstone',
    countryCode: 'UK',
    lat: 52.0717,
    lon: -1.0193,
  ),
  ConcertEntity(
    id: 2,
    city: 'São Paulo',
    countryCode: 'BR',
    lat: -23.5505199,
    lon: -46.6333094,
  ),
  ConcertEntity(
    id: 3,
    city: 'Melbourne',
    countryCode: 'AU',
    lat: -37.8136,
    lon: 144.9631,
  ),
  ConcertEntity(
    id: 4,
    city: 'Monte Carlo',
    countryCode: 'MC',
    lat: 43.7384,
    lon: 7.4246,
  ),
];

const melbourneModels = [
  ConcertModel(
    id: 3,
    city: 'Melbourne',
    countryCode: 'AU',
    lat: -37.8136,
    lon: 144.9631,
  ),
];

const melbourneEntities = [
  ConcertEntity(
    id: 3,
    city: 'Melbourne',
    countryCode: 'AU',
    lat: -37.8136,
    lon: 144.9631,
  ),
];
