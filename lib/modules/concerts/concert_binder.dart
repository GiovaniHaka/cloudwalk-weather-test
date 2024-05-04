import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/modules/concerts/data/repositories/concert_repository_impl.dart';
import 'package:cloudwalk/modules/concerts/data/sources/concert_source.dart';
import 'package:cloudwalk/modules/concerts/data/sources/mock/mock_concert_source_impl.dart';
import 'package:cloudwalk/modules/concerts/domain/repositories/concert_repository.dart';
import 'package:cloudwalk/modules/concerts/domain/usecases/get_concert_usecase.dart';
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
    _getIt.registerFactory<ConcertSource>(
      () => MockConcertSourceImpl(),
    );

    /// [Repositories]
    _getIt.registerFactory<ConcertRepository>(
      () => ConcertRepositoryImpl(
        source: _getIt.get(),
      ),
    );

    /// [Usecases]
    _getIt.registerFactory<GetConcertUsecase>(
      () => GetConcertUsecaseImpl(
        repository: _getIt.get(),
      ),
    );
  }
}
