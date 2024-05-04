import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/core/routers/module_router.dart';
import 'package:cloudwalk/modules/weather/presentation/screens/weather_home_screen.dart';
import 'package:go_router/go_router.dart';

class WeatherRouter implements ModuleRouter {
  static String currentWeather = '/current-weather';

  @override
  routes() {
    return [
      GoRoute(
        name: currentWeather,
        path: currentWeather,
        builder: (context, state) {
          return WeatherHomeScreen(
            currentWeatherController: getIt.get(),
          );
        },
      ),
    ];
  }
}
