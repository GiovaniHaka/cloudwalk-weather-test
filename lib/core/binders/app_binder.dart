import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/core/endpoints/app_endpoints_binder.dart';
import 'package:cloudwalk/modules/concerts/concert_binder.dart';
import 'package:cloudwalk/modules/weather/weather_binder.dart';
import 'package:cloudwalk/shared/services/api_client/api_client_binder.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_binder.dart';
import 'package:cloudwalk/shared/services/env/env_binder.dart';
import 'package:cloudwalk/shared/services/local_data/local_database_binder.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// [AppBinder] is a class that binds all dependencies related to the app.
class AppBinder {
  List<Binder> binders = [
    /// Env
    EnvBinder(getIt: getIt),

    /// Endpoints
    AppEndpointsBinder(getIt: getIt),

    /// Services
    ApiClientBinder(getIt: getIt),
    ConnectivityBinder(getIt: getIt),
    LocalDatabaseBinder(getIt: getIt),

    /// Modules
    ConcertBinder(getIt: getIt),
    WeatherBinder(getIt: getIt),
  ];

  setBinders() {
    for (final binder in binders) {
      binder.bind();
    }
  }
}
