import 'dart:convert';

class Address {
  final double latitude;
  final double longitude;
  final String address;

  const Address({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Address copyWith({
    double? latitude,
    double? longitude,
    String? address,
  }) =>
      Address(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        address: address ?? this.address,
      );

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
      };
}
