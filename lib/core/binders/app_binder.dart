import 'package:cloudwalk/core/endpoints/app_endpoints.dart';
import 'package:cloudwalk/modules/concerts/concert_binder.dart';
import 'package:cloudwalk/modules/weather/weather_binder.dart';
import 'package:cloudwalk/shared/services/api_client/api_client_binder.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_binder.dart';
import 'package:cloudwalk/shared/services/env/env_binder.dart';
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
    /// Env
    EnvBinder(getIt: getIt),

    /// Endpoints
    AppEndpointsBinder(getIt: getIt),

    /// Services
    ApiClientBinder(),
    ConnectivityBinder(),
    LocalDatabaseBinder(),

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
