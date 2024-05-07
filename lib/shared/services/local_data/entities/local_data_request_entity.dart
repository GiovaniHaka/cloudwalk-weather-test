/// [LocalDataRequestEntity] is a class that contains the table and key of the data that is requested from the local data service.
class LocalDataRequestEntity {
  final String table;
  final String key;
  
  LocalDataRequestEntity({
    required this.table,
    required this.key,
  });
}
