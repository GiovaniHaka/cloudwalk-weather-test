import 'dart:io';
import 'package:cloudwalk/shared/services/locale/locale_service.dart';

class DeviceLocaleServiceImpl implements LocaleService {
  @override
  String getCurrentLocale() {
    final localeName = Platform.localeName;

    if (localeName.contains('pt')) {
      return 'pt_BR';
    }

    return 'en_US';
  }
}
