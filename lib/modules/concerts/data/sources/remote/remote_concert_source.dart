import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [RemoteConcertSource] is an abstract class that defines the remote data source for concerts.
///
/// This class defines the contract for retrieving concert data from a remote source.
/// Implementations of this class should provide the implementation details for
/// fetching concert data from a remote API or server.
abstract class RemoteConcertSource {
  /// Retrieves a list of concerts from the remote data source.
  ///
  /// The [searchCity] parameter is an optional filter to search for concerts in a specific city.
  ///
  /// Returns a [Future] that resolves to an [Either] object containing either a [Failure] or a list of [ConcertModel].
  Future<Either<Failure, List<ConcertModel>>> getConcerts({
    String? searchCity,
  });
}
