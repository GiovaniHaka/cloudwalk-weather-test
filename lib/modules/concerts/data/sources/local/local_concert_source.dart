import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [LocalConcertSource] is an abstract class that defines the local data source for concerts.
abstract class LocalConcertSource {
  /// Retrieves a list of concerts from the local data source.
  ///
  /// The [searchCity] parameter is an optional filter to search for concerts in a specific city.
  ///
  /// Returns a [Future] that resolves to an [Either] object containing either a [Failure] or a list of [ConcertModel].
  Future<Either<Failure, List<ConcertModel>>> getConcerts({
    String? searchCity,
  });
}
