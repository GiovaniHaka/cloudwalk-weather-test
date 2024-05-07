import 'package:cloudwalk/shared/commons/failures/failure.dart';

/// [UsecaseFailure] implements [Failure] to handle failures that occur in the usecase.
class UsecaseFailure extends Failure {
  UsecaseFailure({super.error, super.message, super.stackTrace});
}
