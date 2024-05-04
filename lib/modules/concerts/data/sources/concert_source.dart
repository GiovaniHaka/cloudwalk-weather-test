import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [ConcertSource] is a source that retrieves a list of [ConcertModel].
abstract class ConcertSource {
  Future<Either<Failure, List<ConcertModel>>> getConcerts({
    String? searchCity,
  });
}
