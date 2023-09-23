part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isFetchingLocation = false,
    this.isLocationEnabled = false,
    this.hasLocationPermission = false,
    this.address = const Address(
      latitude: 24.524654,
      longitude: 39.569183,
      address: "Al-Madinah al-Munawwarah, Saudi Arabia",
    ),
    this.madhab = "hanafi",
    this.calculationMethod = "Karachi",
    this.higherLatitude = "None",
  });

  final bool isFetchingLocation;
  final bool isLocationEnabled;
  final bool hasLocationPermission;
  final Address address;
  final String madhab;
  final String calculationMethod;
  final String higherLatitude;

  SettingsState copyWith({
    Address? address,
    String? madhab,
    String? calculationMethod,
    String? higherLatitude,
    bool? isFetchingLocation,
    bool? isLocationEnabled,
    bool? hasLocationPermission,
  }) {
    return SettingsState(
      address: address ?? this.address,
      madhab: madhab ?? this.madhab,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      higherLatitude: higherLatitude ?? this.higherLatitude,
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      hasLocationPermission:
          hasLocationPermission ?? this.hasLocationPermission,
    );
  }

  factory SettingsState.fromJson(String str) =>
      SettingsState.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SettingsState.fromMap(Map<String, dynamic> json) => SettingsState(
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

  @override
  List<Object?> get props => [
        address,
        madhab,
        calculationMethod,
        higherLatitude,
        isFetchingLocation,
        isLocationEnabled,
        hasLocationPermission,
      ];
}
