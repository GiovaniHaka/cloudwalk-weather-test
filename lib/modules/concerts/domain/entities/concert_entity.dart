import 'package:equatable/equatable.dart';

/// [ConcertEntity] is a class that represents the concert entity.
class ConcertEntity extends Equatable {
  final int id;
  final String city;
  final String countryCode;
  final double lat;
  final double lon;

  const ConcertEntity({
    required this.id,
    required this.city,
    required this.countryCode,
    required this.lat,
    required this.lon,
  });
  
  @override
  List<Object?> get props => [id, city, countryCode, lat, lon];
}
