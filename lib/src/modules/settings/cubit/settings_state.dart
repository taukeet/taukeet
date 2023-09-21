part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.address,
    required this.madhab,
    required this.calculationMethod,
    required this.higherLatitude,
  });

  final Address address;
  final String madhab;
  final String calculationMethod;
  final String higherLatitude;

  SettingsState copyWith({
    Address? address,
    String? madhab,
    String? calculationMethod,
    String? higherLatitude,
  }) {
    return SettingsState(
      address: address ?? this.address,
      madhab: madhab ?? this.madhab,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      higherLatitude: higherLatitude ?? this.higherLatitude,
    );
  }

  @override
  List<Object?> get props => [
        address,
        madhab,
        calculationMethod,
        higherLatitude,
      ];
}
