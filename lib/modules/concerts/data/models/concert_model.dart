/// [ConcertModel] is a model class that holds the concert data.
class ConcertModel {
  final int id;
  final String city;
  final String countryCode;
  final double lat;
  final double lon;

  ConcertModel({
    required this.id,
    required this.city,
    required this.countryCode,
    required this.lat,
    required this.lon,
  });

  static ConcertModel fromJson(Map<String, dynamic> json) {
    return ConcertModel(
      id: json['id'],
      city: json['city'],
      countryCode: json['countryCode'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }
}
