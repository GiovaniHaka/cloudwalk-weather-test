import 'package:cloudwalk/shared/commons/failures/failure.dart';

/// [ControllerFailure] implements [Failure] to handle failures that occur in the controller.
class ControllerFailure extends Failure {
  ControllerFailure({super.error, super.stackTrace});
}
