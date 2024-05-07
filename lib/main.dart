import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
import 'package:cloudwalk/shared/services/local_data/local_database_service.dart';
import 'package:cloudwalk/shared/services/locale/locale_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'apps/weather_app.dart';

void main() async {
  /// Initialize the binding
  WidgetsFlutterBinding.ensureInitialized();

  /// Set all binders
  AppBinder().setBinders();

  final locale = getIt.get<LocaleService>().getCurrentLocale();

  /// Set the language, and could be changed to any language
  Language.instance.setLanguage(locale);

  /// Set formatters
  Intl.defaultLocale = locale;
  initializeDateFormatting(locale);


  /// Initialize localdatabase
  await getIt.get<LocalDatabaseService>().init();

  runApp(const WeatherApp());
}
