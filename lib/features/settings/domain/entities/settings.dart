import 'dart:convert';

import 'package:taukeet/features/location/domain/entities/address.dart';

class Settings {
    final Address address;
    final String madhab;
    final String calculationMethod;
    final String higherLatitude;

    Settings({
        required this.address,
        required this.madhab,
        required this.calculationMethod,
        required this.higherLatitude,
    });

    Settings copyWith({
        Address? address,
        String? madhab,
        String? calculationMethod,
        String? higherLatitude,
    }) => 
        Settings(
            address: address ?? this.address,
            madhab: madhab ?? this.madhab,
            calculationMethod: calculationMethod ?? this.calculationMethod,
            higherLatitude: higherLatitude ?? this.higherLatitude,
        );

    factory Settings.fromJson(String str) => Settings.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Settings.fromMap(Map<String, dynamic> json) => Settings(
        address: Address.fromMap(json["address"]),
        madhab: json["madhab"],
        calculationMethod: json["calculation_method"],
        higherLatitude: json["higher_latitude"],
    );

    Map<String, dynamic> toMap() => {
        "address": address.toMap(),
        "madhab": madhab,
        "calculation_method": calculationMethod,
        "higher_latitude": higherLatitude,
    };
}