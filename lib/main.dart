import 'package:cloudwalk/shared/services/languages/language.dart';
import 'package:flutter/material.dart';

import 'apps/weather_app.dart';

void main() {
  Language.instance.setLanguage('pt_BR');

  runApp(const WeatherApp());
}
