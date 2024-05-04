import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/mapper_failure.dart';
import 'package:cloudwalk/shared/commons/mapper/mapper.dart';

/// [ConcertMapper] is a mapper that converts [ConcertModel] to [ConcertEntity].
class ConcertMapper implements Mapper<ConcertModel, ConcertEntity> {
  @override
  ConcertEntity toEntity(ConcertModel model) {
    try {
      return ConcertEntity(
        id: model.id,
        city: model.city,
        countryCode: model.countryCode,
        lat: model.lat,
        lon: model.lon,
      );
    } catch (e, s) {
      throw MapperFailure(error: e, stackTrace: s);
    }
  }

  @override
  ConcertModel toModel(ConcertEntity entity) {
    throw UnimplementedError();
  }
}