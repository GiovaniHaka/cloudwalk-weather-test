import 'package:cloudwalk/core/binders/binder.dart';
import 'package:cloudwalk/shared/services/env/env.dart';
import 'package:get_it/get_it.dart';

/// [EnvBinder] is a class that binds all dependencies related to the environment
class EnvBinder implements Binder {
  final GetIt _getIt;

  EnvBinder({
    required GetIt getIt,
  }) : _getIt = getIt;

  @override
  void bind() {
    _getIt.registerSingleton<Env>(Env());
  }
}
