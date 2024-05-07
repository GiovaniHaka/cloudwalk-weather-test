import 'package:cloudwalk/modules/weather/data/mappers/current_weather_mapper.dart';
import 'package:cloudwalk/modules/weather/data/mappers/weather_forecast_mapper.dart';
import 'package:cloudwalk/modules/weather/data/models/current_weather_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_condition_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_forecast_model.dart';
import 'package:cloudwalk/modules/weather/data/models/weather_main_model.dart';
import 'package:cloudwalk/modules/weather/data/sources/local/local_weather_source.dart';
import 'package:cloudwalk/modules/weather/data/sources/remote/remote_weather_source.dart';
import 'package:mocktail/mocktail.dart';

// Models

class MockCurrentWeatherModel extends Mock implements CurrentWeatherModel {}

class MockWeatherConditionModel extends Mock implements WeatherConditionModel {}

class MockWeatherMainModel extends Mock implements WeatherMainModel {}

class MockWeatherForecastModel extends Mock implements WeatherForecastModel {}


// Mappers
class MockCurrentWeatherMapper extends Mock implements CurrentWeatherMapper {}

class MockWeatherForecastMapper extends Mock implements WeatherForecastMapper {}

// Sources

class MockRemoteWeatherSource extends Mock implements RemoteWeatherSource {}

class MockLocalWeatherSource extends Mock implements LocalWeatherSource {}