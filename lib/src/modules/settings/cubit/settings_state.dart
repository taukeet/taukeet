part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.address,
  });

  final Address address;

  SettingsState copyWith({Address? address}) {
    return SettingsState(address: address ?? this.address);
  }

  @override
  List<Object?> get props => [address];
}
