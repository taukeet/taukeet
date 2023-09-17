part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.address,
    required this.madhab,
    required this.calculationMethod,
  });

  final Address address;
  final String madhab;
  final String calculationMethod;

  SettingsState copyWith({
    Address? address,
    String? madhab,
    String? calculationMethod,
  }) {
    return SettingsState(
      address: address ?? this.address,
      madhab: madhab ?? this.madhab,
      calculationMethod: calculationMethod ?? this.calculationMethod,
    );
  }

  @override
  List<Object?> get props => [address, madhab, calculationMethod];
}
