
import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/core/endpoints/app_endpoints.dart';
import 'package:get_it/get_it.dart';

class AppEndpointsBinder implements Binder {
  final GetIt _getIt;

  const AppEndpointsBinder({
    required GetIt getIt,
  }) : _getIt = getIt;

  @override
  void bind() {
    _getIt.registerSingleton<AppEndpoints>(const AppEndpointsImpl());
  }
}