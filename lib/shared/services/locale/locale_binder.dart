import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/shared/services/locale/locale_service.dart';
import 'package:cloudwalk/shared/services/locale/locales/device_locale_service_impl.dart';
import 'package:get_it/get_it.dart';

/// [LocaleBinder] is a class that binds all dependencies related to the locale.
class LocaleBinder implements Binder {
  final GetIt _getIt;

  LocaleBinder({
    required GetIt getIt,
  }) : _getIt = getIt;

  @override
  void bind() {
    /// [Services]
    _getIt.registerSingleton<LocaleService>(
      DeviceLocaleServiceImpl(),
    );
  }
}
