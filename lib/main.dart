import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';
import 'package:flutter/material.dart';

import 'apps/weather_app.dart';

void main() {
  /// Set the language, and could be changed to any language
  Language.instance.setLanguage('pt_BR');

  /// Set all binders
  AppBinder().setBinders();

  runApp(const WeatherApp());
}
