import 'package:cloudwalk/shared/services/local_data/entities/local_data_input_entity.dart';
import 'package:cloudwalk/shared/services/local_data/entities/local_data_request_entity.dart';

/// [LocalDatabaseService] is a service that provides methods to interact with the local database.
abstract class LocalDatabaseService {
  Future<void> init();
  Future<dynamic> get(LocalDataRequestEntity request);
  Future<void> put(LocalDataInputEntity input);
  Future<void> delete(LocalDataRequestEntity request);
  Future<void> clearAll();
}
