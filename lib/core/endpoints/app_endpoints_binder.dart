import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/core/endpoints/app_endpoints.dart';
import 'package:get_it/get_it.dart';

/// [AppEndpointsBinder] is a class that binds all dependencies related to the app endpoints.
class AppEndpointsBinder implements Binder {
  final GetIt _getIt;

  const AppEndpointsBinder({
    required GetIt getIt,
  }) : _getIt = getIt;

  @override
  void bind() {
    _getIt.registerSingleton<AppEndpoints>(const ProductionEndpointsImpl());
  }
}
