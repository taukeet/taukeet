part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isFetchingLocation = false,
    this.isLocationEnabled = true,
    this.hasFetchedInitialLocation = false,
    this.hasLocationPermission = true,
    this.isTutorialCompleted = false,
    this.address = const Address(
      latitude: 0.0,
      longitude: 0.0,
      address: "",
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
  });

  final bool isFetchingLocation;
  final bool isLocationEnabled;
  final bool hasFetchedInitialLocation;
  final bool hasLocationPermission;
  final bool isTutorialCompleted;
  final Address address;
  final Adjustments adjustments;
  final String madhab;
  final String calculationMethod;
  final String higherLatitude;

  String get madhabStr => madhab == "shafi" ? "Standard" : "Hanafi";

  SettingsState copyWith({
    Address? address,
    Adjustments? adjustments,
    String? madhab,
    String? calculationMethod,
    String? higherLatitude,
    bool? isFetchingLocation,
    bool? isLocationEnabled,
    bool? hasLocationPermission,
    bool? hasFetchedInitialLocation,
    bool? isTutorialCompleted,
  }) {
    return SettingsState(
      address: address ?? this.address,
      adjustments: adjustments ?? this.adjustments,
      madhab: madhab ?? this.madhab,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      higherLatitude: higherLatitude ?? this.higherLatitude,
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
      hasFetchedInitialLocation:
          hasFetchedInitialLocation ?? this.hasFetchedInitialLocation,
      isTutorialCompleted: isTutorialCompleted ?? this.isTutorialCompleted,
    );
  }

  factory SettingsState.fromJson(String str) =>
      SettingsState.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SettingsState.fromMap(Map<String, dynamic> json) => SettingsState(
        address: Address.fromMap(json["address"]),
        adjustments: Adjustments.fromMap(json["adjustments"]),
        madhab: json["madhab"],
        calculationMethod: json["calculation_method"],
        higherLatitude: json["higher_latitude"],
        hasFetchedInitialLocation: json['has_fetched_initial_location'],
        isTutorialCompleted: json['is_tutorial_completed'],
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
  List<Object?> get props => [
        address,
        adjustments,
        madhab,
        calculationMethod,
        higherLatitude,
        isFetchingLocation,
        isLocationEnabled,
        hasLocationPermission,
        hasFetchedInitialLocation,
        isTutorialCompleted,
      ];
}
