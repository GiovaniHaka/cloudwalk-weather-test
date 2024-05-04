/// [ConcertEntity] is a class that represents the concert entity.
class ConcertEntity {
  final int id;
  final String city;
  final String countryCode;
  final double lat;
  final double lon;

  ConcertEntity({
    required this.id,
    required this.city,
    required this.countryCode,
    required this.lat,
    required this.lon,
  });
}
