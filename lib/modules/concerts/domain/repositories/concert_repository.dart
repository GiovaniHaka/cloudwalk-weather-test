import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [ConcertRepository] is an abstract class that defines the repository for concerts.
abstract class ConcertRepository {
  Future<Either<Failure, List<ConcertEntity>>> getConcerts({
    String? searchCity,
  });
}
