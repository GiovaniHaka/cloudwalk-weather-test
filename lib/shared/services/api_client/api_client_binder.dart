import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/shared/services/api_client/api_client_service.dart';
import 'package:cloudwalk/shared/services/api_client/clients/dio_client_service_impl.dart';
import 'package:get_it/get_it.dart';

/// [ApiClientBinder] is a class that binds all dependencies related to the API client.
class ApiClientBinder implements Binder {
  final GetIt _getIt;

  ApiClientBinder({
    required GetIt getIt,
  }) : _getIt = getIt;

  @override
  void bind() {
    /// [Controller]
    _getIt.registerSingleton<ApiClientService>(
      DioClientServiceImpl(),
    );
  }
}
