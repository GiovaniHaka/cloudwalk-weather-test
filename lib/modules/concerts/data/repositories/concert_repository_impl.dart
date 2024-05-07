import 'package:cloudwalk/modules/concerts/data/mappers/concert_mapper.dart';
import 'package:cloudwalk/modules/concerts/data/models/concert_model.dart';
import 'package:cloudwalk/modules/concerts/data/sources/local/local_concert_source.dart';
import 'package:cloudwalk/modules/concerts/data/sources/remote/remote_concert_source.dart';
import 'package:cloudwalk/modules/concerts/domain/entities/concert_entity.dart';
import 'package:cloudwalk/modules/concerts/domain/repositories/concert_repository.dart';
import 'package:cloudwalk/shared/commons/failures/data_failures/repository_failure.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_service.dart';
import 'package:dartz/dartz.dart';

/// [ConcertRepositoryImpl] is a repository that implements [ConcertRepository].
class ConcertRepositoryImpl implements ConcertRepository {
  final RemoteConcertSource _remoteSource;
  final LocalConcertSource _localSource;
  final ConnectivityService _connectivityService;
  final ConcertMapper _concertMapper;

  ConcertRepositoryImpl({
    required RemoteConcertSource remoteSource,
    required LocalConcertSource localSource,
    required ConnectivityService connectivityService,
    required ConcertMapper concertMapper,
  })  : _remoteSource = remoteSource,
        _localSource = localSource,
        _connectivityService = connectivityService,
        _concertMapper = concertMapper;

  bool get isOffline => _connectivityService.isOffline;

  @override
  Future<Either<Failure, List<ConcertEntity>>> getConcerts({
    String? searchCity,
  }) async {
    try {
      Either<Failure, List<ConcertModel>> result;

      if (isOffline) {
        result = await _localSource.getConcerts(searchCity: searchCity);
      } else {
        result = await _remoteSource.getConcerts(searchCity: searchCity);
      }

      return result.fold(
        (failure) {
          return Left(failure);
        },
        (concerts) {
          final entities = concerts.map((e) {
            return _concertMapper.toEntity(e);
          }).toList();

          return Right(entities);
        },
      );
    } catch (e, s) {
      return Left(RepositoryFailure(error: e, stackTrace: s));
    }
  }
}
