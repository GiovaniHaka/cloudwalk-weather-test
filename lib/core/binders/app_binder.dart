import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// Abstract class for binding dependencies
abstract class Binder {
  void bind();
}

/// Class to bind all dependencies in the app
class AppBinder {
  List<Binder> binders = [];

  setBinders() {
    for (final binder in binders) {
      binder.bind();
    }
  }
}
