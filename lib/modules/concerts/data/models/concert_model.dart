import 'package:equatable/equatable.dart';

/// [ConcertModel] is a model class that holds the concert data.
class ConcertModel extends Equatable {
  final int id;
  final String city;
  final String countryCode;
  final double lat;
  final double lon;

  const ConcertModel({
    required this.id,
    required this.city,
    required this.countryCode,
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [id, city, countryCode, lat, lon];
}
