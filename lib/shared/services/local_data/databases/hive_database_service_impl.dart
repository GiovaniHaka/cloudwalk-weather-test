import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloudwalk/shared/commons/failures/failure.dart';
import 'package:cloudwalk/shared/services/local_data/entities/local_data_input_entity.dart';
import 'package:cloudwalk/shared/services/local_data/entities/local_data_request_entity.dart';
import 'package:cloudwalk/shared/services/local_data/local_database_service.dart';

class HiveDatabaseServiceImpl implements LocalDatabaseService {
  @override
  Future<dynamic> get(
    LocalDataRequestEntity request,
  ) async {
    try {
      final box = await Hive.openBox(request.table);

      final data = await box.get(request.key);

      return data;
    } catch (e, s) {
      throw Failure(error: e, stackTrace: s);
    }
  }

  @override
  Future<void> put(LocalDataInputEntity input) async {
    try {
      final box = await Hive.openBox(input.table);

      await box.put(input.key, input.value);
    } catch (e, s) {
      throw Failure(error: e, stackTrace: s);
    }
  }

  @override
  Future<void> delete(LocalDataRequestEntity request) async {
    try {
      final box = await Hive.openBox(request.table);

      await box.delete(request.key);
    } catch (e, s) {
      throw Failure(error: e, stackTrace: s);
    }
  }
}
