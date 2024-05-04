import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'apps/weather_app.dart';

void main() async {
  /// Initialize the binding
  WidgetsFlutterBinding.ensureInitialized();

  /// Set the language, and could be changed to any language
  Language.instance.setLanguage('pt_BR');

  /// Set formatters
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting('pt_BR');

  /// Set all binders
  AppBinder().setBinders();

  runApp(const WeatherApp());
}
