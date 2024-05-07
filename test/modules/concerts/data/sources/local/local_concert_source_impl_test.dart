import 'package:cloudwalk/modules/concerts/data/mappers/concert_mapper.dart';
import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/modules/concerts/data/sources/local/local_concert_source_impl.dart';
import 'package:cloudwalk/shared/commons/extensions/either_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LocalConcertSourceImpl remoteConcertSource;

  setUp(() {
    remoteConcertSource = LocalConcertSourceImpl(
      concertMapper: ConcertMapper(),
    );
  });

  group('$LocalConcertSourceImpl', () {
    test('getConcerts should return a list of ConcertModel', () async {
      // Arrange
      const expectedModels = [
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

      // Act
      final result = await remoteConcertSource.getConcerts(
        searchCity: null,
      );

      // Assert
      expect(result.toRight(), equals(expectedModels));
    });

    test('getConcerts should filter concerts by searchCity', () async {
      // Arrange
      const searchCity = 'Melbourne';

      const expectedModels = [
        ConcertModel(
          id: 3,
          city: 'Melbourne',
          countryCode: 'AU',
          lat: -37.8136,
          lon: 144.9631,
        ),
      ];

      // Act
      final result = await remoteConcertSource.getConcerts(
        searchCity: searchCity,
      );

      // Assert
      expect(result.toRight(), equals(expectedModels));
    });
  });
}
