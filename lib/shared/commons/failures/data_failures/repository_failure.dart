
import 'package:cloudwalk/shared/commons/failures/failure.dart';

/// [RepositoryFailure] implements [Failure] to handle failures that occur in the repository.
class RepositoryFailure extends Failure {
  RepositoryFailure({super.error, super.message, super.stackTrace});
}
