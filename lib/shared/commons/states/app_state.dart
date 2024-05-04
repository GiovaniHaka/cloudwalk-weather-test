import 'package:cloudwalk/shared/commons/failures/failure.dart';

/// [AppState] is a class that represents the state of the application.
abstract class AppState<T> {
  set data(T data) => throw UnimplementedError();
  T get data => throw UnimplementedError('$this');

  set failure(Failure data) => throw UnimplementedError();
  Failure get failure => throw UnimplementedError();
}

class Initial<T> extends AppState<T> {}

class Loading<T> extends AppState<T> {}

class Empty<T> extends AppState<T> {}

class Error<T> extends AppState<T> {
  late Failure _failure;

  @override
  Failure get failure => _failure;

  @override
  set failure(Failure data) {
    _failure = data;
  }

  Error([Failure? failure]) : _failure = failure ?? Failure();
}

class Loaded<T> extends AppState<T> {
  late T _data;

  @override
  T get data => _data;

  @override
  set data(T data) {
    _data = data;
  }

  Loaded(T value) {
    data = value;
  }
}
