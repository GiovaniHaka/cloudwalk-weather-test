import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/core/routers/module_router.dart';
import 'package:cloudwalk/modules/concerts/presentation/screens/concerts_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// [ConcertRouter] is a class that routes all paths related to the concert module
class ConcertRouter implements ModuleRouter {
  static String concerts = '/concerts';

  @override
  routes() {
    return [
      GoRoute(
        name: concerts,
        path: concerts,
        builder: (context, state) {
          return ConcertsScreen(
            concertsController: getIt.get(),
            currentWeatherController: getIt.get(),
          );
        },
      ),
    ];
  }

  static goToConcerts(BuildContext context) {
    context.push(concerts);
  }
}
