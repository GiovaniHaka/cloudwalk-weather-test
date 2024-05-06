import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_service.dart';

/// [ConnectivityBinder] is a class that will bind all the dependencies related to the connectivity service.
class ConnectivityBinder extends Binder {
  @override
  void bind() {
    /// [DataSources]
    getIt.registerLazySingleton<ConnectivityService>(
      () => ConnectivityService(),
    );
  }
}
