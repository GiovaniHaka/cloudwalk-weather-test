import 'package:cloudwalk/shared/commons/logs/colorful_logs.dart';
import 'package:cloudwalk/shared/services/languages/language.dart';

class Failure {
  late String _message;
  late Object? _error;
  late StackTrace? _stackTrace;

  Failure({String? message, Object? error, StackTrace? stackTrace}) {
    _message = message ?? Language.instance.lang.failureMessage;
    _error = error ;
    _stackTrace = stackTrace;
    logError('error: $_error\nstackTrace: $_stackTrace');
  }

  String get message => _message;

  Object? get error => _error;

  StackTrace? get stackTrace => _stackTrace;
}
