import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/shared/services/api_client/api_client_service.dart';
import 'package:cloudwalk/shared/services/api_client/clients/dio_client_service_impl.dart';

/// [ApiClientBinder] is a class that binds all dependencies related to the API client.
class ApiClientBinder implements Binder {
  @override
  void bind() {
    /// [Controller]
    getIt.registerSingleton<ApiClientService>(
      DioClientServiceImpl(),
    );
  }
}
