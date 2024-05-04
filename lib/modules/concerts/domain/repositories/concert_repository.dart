import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [ConcertRepository] is a repository that retrieves a list of [ConcertEntity].
abstract class ConcertRepository {
  Future<Either<Failure, List<ConcertEntity>>> getConcerts();
}
