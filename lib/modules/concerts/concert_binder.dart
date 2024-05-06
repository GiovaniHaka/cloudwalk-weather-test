import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/modules/concerts/data/repositories/concert_repository_impl.dart';
import 'package:cloudwalk/modules/concerts/data/sources/mock_local_source/local_concert_source.dart';
import 'package:cloudwalk/modules/concerts/data/sources/mock_local_source/mock_local_concert_source_impl.dart';
import 'package:cloudwalk/modules/concerts/data/sources/mock_remote_source/remote_concert_source.dart';
import 'package:cloudwalk/modules/concerts/data/sources/mock_remote_source/mock_remote_concert_source_impl.dart';
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
    /// [Sources]
    _getIt.registerFactory<RemoteConcertSource>(
      () => MockRemoteConcertSourceImpl(),
    );

    _getIt.registerFactory<LocalConcertSource>(
      () => MockLocalConcertSourceImpl(),
    );

    /// [Repositories]
    _getIt.registerFactory<ConcertRepository>(
      () => ConcertRepositoryImpl(
        remoteSource: _getIt.get(),
        localSource: _getIt.get(),
        connectivityService: _getIt.get(),
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
      ),
    );
  }
}
