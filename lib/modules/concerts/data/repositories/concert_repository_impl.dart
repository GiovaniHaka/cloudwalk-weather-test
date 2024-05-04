import 'package:cloudwalk/modules/concerts/data/mappers/concert_mapper.dart';
import 'package:cloudwalk/modules/concerts/data/sources/concert_source.dart';
import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/concerts/domain/repositories/concert_repository.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/repository_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [ConcertRepositoryImpl] is a repository that implements [ConcertRepository].
class ConcertRepositoryImpl implements ConcertRepository {
  final ConcertSource _source;

  ConcertRepositoryImpl({
    required ConcertSource source,
  }) : _source = source;

  @override
  Future<Either<Failure, List<ConcertEntity>>> getConcerts({
    String? searchCity,
  }) async {
    try {
      final result = await _source.getConcerts(searchCity: searchCity);

      return result.fold(
        (failure) {
          return Left(failure);
        },
        (concerts) {
          final entities = concerts.map((e) {
            return ConcertMapper().toEntity(e);
          }).toList();

          return Right(entities);
        },
      );
    } catch (e, s) {
      return Left(RepositoryFailure(error: e, stackTrace: s));
    }
  }
}
