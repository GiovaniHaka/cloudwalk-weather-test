/// [LocalDataInputEntity] is a class that contains the table, key, and value of the local data.
class LocalDataInputEntity {
  final String table;
  final String key;
  final dynamic value;
  
  LocalDataInputEntity({
    required this.table,
    required this.key,
    required this.value,
  });
}
