import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/shared/services/local_data/local_database_service.dart';
import 'package:cloudwalk/shared/services/local_data/databases/hive_database_service_impl.dart';

class LocalDatabaseBinder extends Binder {
  @override
  void bind() {
    /// [DataSources]
    getIt.registerFactory<LocalDatabaseService>(
      () => HiveDatabaseServiceImpl(),
    );
  }
}
