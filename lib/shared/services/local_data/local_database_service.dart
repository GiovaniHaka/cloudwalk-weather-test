import 'package:cloudwalk/shared/services/local_data/entities/local_data_input_entity.dart';
import 'package:cloudwalk/shared/services/local_data/entities/local_data_request_entity.dart';

abstract class LocalDatabaseService {
  Future<dynamic> get(LocalDataRequestEntity request);
  Future<void> put(LocalDataInputEntity input);
  Future<void> delete(LocalDataRequestEntity request);
}
