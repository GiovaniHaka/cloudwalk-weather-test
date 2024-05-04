// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

/// [Env] is a class that contains all the environment variables used in the app with security.
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'OPEN_WEATHER_API_KEY', obfuscate: true)
  static String openWeatherApiKey = _Env.openWeatherApiKey;
}
