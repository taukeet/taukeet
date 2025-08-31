import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';

class Settings extends Equatable {
  final Address address;
  final Adjustments adjustments;
  final String madhab;
  final String calculationMethod;
  final String higherLatitude;
  final bool hasFetchedInitialLocation;
  final bool isTutorialCompleted;

  const Settings({
    this.address = const Address(
      latitude: 24.4667,
      longitude: 39.6,
      address: "Madina, Saudi Arabia",
    ),
    this.adjustments = const Adjustments(
      fajr: 0,
      sunrise: 0,
      dhuhr: 0,
      asr: 0,
      maghrib: 0,
      isha: 0,
    ),
    this.madhab = "hanafi",
    this.calculationMethod = "Karachi",
    this.higherLatitude = "None",
    this.hasFetchedInitialLocation = false,
    this.isTutorialCompleted = false,
  });

  Settings copyWith({
    Address? address,
    Adjustments? adjustments,
    String? madhab,
    String? calculationMethod,
    String? higherLatitude,
    bool? hasFetchedInitialLocation,
    bool? isTutorialCompleted,
  }) =>
      Settings(
        address: address ?? this.address,
        adjustments: adjustments ?? this.adjustments,
        madhab: madhab ?? this.madhab,
        calculationMethod: calculationMethod ?? this.calculationMethod,
        higherLatitude: higherLatitude ?? this.higherLatitude,
        hasFetchedInitialLocation:
            hasFetchedInitialLocation ?? this.hasFetchedInitialLocation,
        isTutorialCompleted: isTutorialCompleted ?? this.isTutorialCompleted,
      );

  factory Settings.fromJson(String str) => Settings.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Settings.fromMap(Map<String, dynamic> json) => Settings(
        address: json["address"] != null
            ? Address.fromMap(json["address"])
            : const Address(latitude: 0.0, longitude: 0.0, address: ""),
        adjustments: json["adjustments"] != null
            ? Adjustments.fromMap(json["adjustments"])
            : const Adjustments(
                fajr: 0,
                sunrise: 0,
                dhuhr: 0,
                asr: 0,
                maghrib: 0,
                isha: 0,
              ),
        madhab: json["madhab"] ?? "hanafi",
        calculationMethod: json["calculation_method"] ?? "Karachi",
        higherLatitude: json["higher_latitude"] ?? "None",
        hasFetchedInitialLocation:
            json["has_fetched_initial_location"] ?? false,
        isTutorialCompleted: json["is_tutorial_completed"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "address": address.toMap(),
        "adjustments": adjustments.toMap(),
        "madhab": madhab,
        "calculation_method": calculationMethod,
        "higher_latitude": higherLatitude,
        "has_fetched_initial_location": hasFetchedInitialLocation,
        "is_tutorial_completed": isTutorialCompleted,
      };

  @override
  List<Object> get props => [
        address,
        adjustments,
        madhab,
        calculationMethod,
        higherLatitude,
        hasFetchedInitialLocation,
        isTutorialCompleted,
      ];
}
