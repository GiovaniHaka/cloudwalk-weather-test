import 'package:cloudwalk/core/binders/app_binder.dart';
import 'package:cloudwalk/shared/services/env/env.dart';
import 'package:get_it/get_it.dart';

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
