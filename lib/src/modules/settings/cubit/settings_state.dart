part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.address,
    required this.madhab,
  });

  final Address address;
  final String madhab;

  SettingsState copyWith({Address? address, String? madhab}) {
    return SettingsState(
      address: address ?? this.address,
      madhab: madhab ?? this.madhab,
    );
  }

  @override
  List<Object?> get props => [address, madhab];
}
