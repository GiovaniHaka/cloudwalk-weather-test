import 'package:intl/locale.dart';
import 'package:cloudwalk/shared/services/locale/locale_service.dart';
import 'package:intl/intl.dart';

class DeviceLocaleServiceImpl implements LocaleService {
  @override
  String getCurrentLocale() {
    final locale = Locale.parse(Intl.getCurrentLocale());
    final localeLanguageCode = locale.languageCode;

    switch (localeLanguageCode) {
      case 'pt':
        return 'pt_BR';
      default:
        return 'en_US';
    }
  }
}
