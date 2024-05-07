import 'package:dartz/dartz.dart';

extension EitherExtension<L, R> on Either<L, R> {
  R toRight() => (this as Right).value; //
  L toLeft() => (this as Left).value;
}
