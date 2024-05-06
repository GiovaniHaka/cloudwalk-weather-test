import 'package:cloudwalk/shared/commons/failures/failure.dart';

/// [EntityFailure] implements [Failure] to handle failures that occur in the entity.
class EntityFailure extends Failure {
  EntityFailure({super.error, super.stackTrace});
}
