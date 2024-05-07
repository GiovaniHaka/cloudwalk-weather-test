import 'package:cloudwalk/shared/commons/failures/failure.dart';

/// [MapperFailure] implements [Failure] to handle failures that occur in the mapper.
class MapperFailure extends Failure {
  MapperFailure({super.error, super.stackTrace});
}
