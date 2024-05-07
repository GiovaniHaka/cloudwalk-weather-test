import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/concerts/domain/repositories/concert_repository.dart';
import 'package:cloudwalk/shared/commons/failures/domain_failures/usecase_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [GetConcertUsecase] is a usecase that retrieves a list of [ConcertEntity].
abstract class GetConcertUsecase {
  /// Retrieves a list of [ConcertEntity] based on the provided search city.
  ///
  /// Returns a [Future] that resolves to an [Either] containing a [Failure] or a list of [ConcertEntity].
  ///
  /// The [searchCity] parameter is an optional [String] used to filter the concerts by city.
  Future<Either<Failure, List<ConcertEntity>>> call({
    String? searchCity,
  });
}

/// [GetConcertUsecaseImpl] is an implementation of the [GetConcertUsecase] usecase.
class GetConcertUsecaseImpl implements GetConcertUsecase {
  final ConcertRepository _repository;

  GetConcertUsecaseImpl({
    required ConcertRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, List<ConcertEntity>>> call({
    String? searchCity,
  }) async {
    try {
      final search = searchCity?.trim();

      return _repository.getConcerts(
        searchCity: search,
      );
    } catch (e, s) {
      return Left(UsecaseFailure(error: e, stackTrace: s));
    }
  }
}
