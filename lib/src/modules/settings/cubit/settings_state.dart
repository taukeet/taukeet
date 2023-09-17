part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.address,
    required this.dateTime,
  });

  final Address address;
  final DateTime dateTime;

  SettingsState copyWith({Address? address, DateTime? dateTime}) {
    return SettingsState(
        address: address ?? this.address, dateTime: dateTime ?? this.dateTime);
  }

  @override
  List<Object?> get props => [address];
}
