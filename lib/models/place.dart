import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class Place {
  final String name;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;

  Place({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  /// Factory constructor for creating a `Place` instance from JSON.
  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  /// Method to convert a `Place` instance to a JSON map.
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  /// Method to convert a `Place` instance to a map for SQLite.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  /// Factory constructor for creating a `Place` instance from a SQLite map.
  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
