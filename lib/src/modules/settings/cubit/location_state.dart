part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState({
    required this.isFetchingLocation,
    required this.address,
  });

  final bool isFetchingLocation;
  final Address address;

  LocationState copyWith({
    bool? isFetchingLocation,
    Address? address,
  }) {
    return LocationState(
      isFetchingLocation: isFetchingLocation ?? this.isFetchingLocation,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [isFetchingLocation, address];
}
