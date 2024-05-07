import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/modules/concerts/data/mappers/concert_mapper.dart';
import 'package:cloudwalk/modules/concerts/data/repositories/concert_repository_impl.dart';
import 'package:cloudwalk/modules/concerts/data/sources/local/local_concert_source.dart';
import 'package:cloudwalk/modules/concerts/data/sources/local/local_concert_source_impl.dart';
import 'package:cloudwalk/modules/concerts/data/sources/remote/remote_concert_source.dart';
import 'package:cloudwalk/modules/concerts/data/sources/remote/remote_concert_source_impl.dart';
import 'package:cloudwalk/modules/concerts/domain/repositories/concert_repository.dart';
import 'package:cloudwalk/modules/concerts/domain/usecases/get_concert_usecase.dart';
import 'package:cloudwalk/modules/concerts/presentation/controllers/concerts_controller.dart';
import 'package:get_it/get_it.dart';

/// [ConcertBinder] is a class that binds all dependencies related to the weather module
class ConcertBinder implements Binder {
  final GetIt _getIt;

  ConcertBinder({
    required GetIt getIt,
  }) : _getIt = getIt;

  @override
  void bind() {
    /// [Mappers]
    _getIt.registerFactory<ConcertMapper>(
      () => ConcertMapper(),
    );

    /// [Sources]
    _getIt.registerFactory<RemoteConcertSource>(
      () => RemoteConcertSourceImpl(
        concertMapper: _getIt.get(),
      ),
    );

    _getIt.registerFactory<LocalConcertSource>(
      () => LocalConcertSourceImpl(
        concertMapper: _getIt.get(),
      ),
    );

    /// [Repositories]
    _getIt.registerFactory<ConcertRepository>(
      () => ConcertRepositoryImpl(
        remoteSource: _getIt.get(),
        localSource: _getIt.get(),
        connectivityService: _getIt.get(),
        concertMapper: _getIt.get(),
      ),
    );

    /// [Usecases]
    _getIt.registerFactory<GetConcertUsecase>(
      () => GetConcertUsecaseImpl(
        repository: _getIt.get(),
      ),
    );

    /// [Controllers]
    _getIt.registerFactory<ConcertsController>(
      () => ConcertsController(
        getConcertUsecase: _getIt.get(),
        timerCall: _getIt.get(),
      ),
    );
  }
}
