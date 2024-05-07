import 'package:cloudwalk/modules/weather/domain/entities/current_weather_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_forecast_entity.dart';
import 'package:cloudwalk/modules/weather/domain/entities/weather_main_entity.dart';
import 'package:cloudwalk/modules/weather/domain/repositories/weather_repository.dart';
import 'package:cloudwalk/modules/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:cloudwalk/modules/weather/domain/usecases/get_weather_forecast_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Entities
class MockWeatherMainEntity extends Mock implements WeatherMainEntity {}

class MockCurrentWeatherEntity extends Mock implements CurrentWeatherEntity {}

class MockWeatherForecastEntity extends Mock implements WeatherForecastEntity {}

// Repositories
class MockWeatherRepository extends Mock implements WeatherRepository {}

// Usecases

class MockGetCurrentWeatherUsecase extends Mock
    implements GetCurrentWeatherUsecase {}

class MockGetWeatherForecastUsecase extends Mock
    implements GetWeatherForecastUsecase {}
