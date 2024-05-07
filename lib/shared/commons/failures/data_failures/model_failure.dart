import 'package:cloudwalk/shared/commons/failures/failure.dart';

/// [ModelFailure] implements [Failure] to handle failures that occur in the model.
class ModelFailure extends Failure {
  ModelFailure({super.error, super.stackTrace});
}
