import 'package:cloudwalk/shared/services/api_client/api_client_binder.dart';
import 'package:cloudwalk/shared/services/local_data/local_database_binder.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// Abstract class for binding dependencies
abstract class Binder {
  void bind();
}

/// Class to bind all dependencies in the app
class AppBinder {
  List<Binder> binders = [
    ApiClientBinder(),
    LocalDatabaseBinder(),
  ];

  setBinders() {
    for (final binder in binders) {
      binder.bind();
    }
  }
}
