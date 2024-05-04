import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/concerts/domain/repositories/concert_repository.dart';
import 'package:cloudwalk/shared/commons/failures/domain_failures/usecase_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:dartz/dartz.dart';

/// [GetConcertUsecase] is a usecase that retrieves a list of [ConcertEntity].
abstract class GetConcertUsecase {
  Future<Either<Failure, List<ConcertEntity>>> call();
}

/// [GetConcertUsecaseImpl] is a usecase that retrieves a list of [ConcertEntity].
class GetConcertUsecaseImpl implements GetConcertUsecase {
  final ConcertRepository _repository;

  GetConcertUsecaseImpl({
    required ConcertRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, List<ConcertEntity>>> call() async {
    try {
      return _repository.getConcerts();
    } catch (e, s) {
      return Left(UsecaseFailure(error: e, stackTrace: s));
    }
  }
}
