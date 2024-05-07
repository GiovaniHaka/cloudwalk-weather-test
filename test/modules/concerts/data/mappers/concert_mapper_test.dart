import 'package:cloudwalk/modules/concerts/data/mappers/concert_mapper.dart';
import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../weather/presentation/controllers/current_weather_controller_test.dart';
import '../concert_data_mocks.dart';

void main() {
  late ConcertMapper mapper;

  setUpAll(() {
    mapper = ConcertMapper();
  });

  group('$ConcertMapper', () {
    test('toEntity should convert ConcertModel to ConcertEntity', () {
      const model = ConcertModel(
        id: 1,
        city: 'city',
        countryCode: 'countryCode',
        lat: 1.0,
        lon: 1.0,
      );

      const expectedEntity = ConcertEntity(
        id: 1,
        city: 'city',
        countryCode: 'countryCode',
        lat: 1.0,
        lon: 1.0,
      );

      final entity = mapper.toEntity(model);
      expect(entity, expectedEntity);
    });

    test('modelFromJson should convert json to ConcertModel', () {
      final json = {
        'id': 1,
        'city': 'city',
        'countryCode': 'countryCode',
        'lat': 1.0,
        'lon': 1.0,
      };

      final model = mapper.modelFromJson(json);

      const expectedModel = ConcertModel(
        id: 1,
        city: 'city',
        countryCode: 'countryCode',
        lat: 1.0,
        lon: 1.0,
      );

      expect(model, expectedModel);
    });

    test('toEntity should throw MapperFailure if an error occurs', () {
      expect(
        () => mapper.toEntity(MockConcertModel()),
        throwsA(isA<MapperFailure>()),
      );
    });

    test('toModel should throw UnimplementedError', () {
      expect(
        () => mapper.toModel(MockConcertEntity()),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
