import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/shared/services/connectivity/connectivity_service.dart';
import 'package:get_it/get_it.dart';

/// [ConnectivityBinder] is a class that will bind all the dependencies related to the connectivity service.
class ConnectivityBinder extends Binder {
  final GetIt _getIt;

  ConnectivityBinder({
    required GetIt getIt,
  }) : _getIt = getIt;

  @override
  void bind() {
    /// [DataSources]
    _getIt.registerLazySingleton<ConnectivityService>(
      () => ConnectivityService(),
    );
  }
}
