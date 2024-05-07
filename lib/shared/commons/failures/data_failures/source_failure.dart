import 'package:cloudwalk/shared/commons/failures/failure.dart';

/// [SourceFailure] implements [Failure] to handle failures that occur in the source.
class SourceFailure extends Failure {
  SourceFailure({super.error, super.message, super.stackTrace});
}
