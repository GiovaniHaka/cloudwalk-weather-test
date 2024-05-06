import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/shared/services/local_data/local_database_service.dart';
import 'package:cloudwalk/shared/services/local_data/databases/hive_database_service_impl.dart';
import 'package:get_it/get_it.dart';

class LocalDatabaseBinder extends Binder {
  final GetIt _getIt;

  LocalDatabaseBinder({
    required GetIt getIt,
  }) : _getIt = getIt;
  
  @override
  void bind() {
    /// [DataSources]
    _getIt.registerFactory<LocalDatabaseService>(
      () => HiveDatabaseServiceImpl(),
    );
  }
}
