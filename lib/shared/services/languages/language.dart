import 'package:cloudwalk/shared/services/languages/dictionary.dart';
import 'package:cloudwalk/shared/services/languages/dictionaries/brazilian_portuguese_dictionary.dart';

class Language {
  static late String _locale;
  late Dictionary lang;

  Language._();

  static final instance = Language._();

  void setLanguage(String locale) {
    _locale = locale;
    switch (_locale) {
      case 'pt_BR':
        lang = const BrazilianPortugueseDictionary();
        break;
      default:
        lang = const BrazilianPortugueseDictionary();
        break;
    }
  }
}
