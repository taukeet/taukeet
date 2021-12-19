part of 'intro_cubit.dart';

class IntroState extends Equatable {
  final List<CalculationMethod> calculationMethods;
  final String calculationMethod;
  final String madhab;
  final double latitude;
  final double longitude;
  final String address;

  final bool isAddressFetching;
  final bool isAddressFetched;

  const IntroState({
    this.calculationMethods = const [],
    this.calculationMethod = "muslim_world_league",
    this.madhab = "hanfi",
    this.latitude = 0,
    this.longitude = 0,
    this.address = "",
    this.isAddressFetching = false,
    this.isAddressFetched = false,
  });

  IntroState copyWith({
    List<CalculationMethod>? calculationMethods,
    String? calculationMethod,
    String? madhab,
    double? latitude,
    double? longitude,
    String? address,
    bool? isAddressFetching,
    bool? isAddressFetched,
  }) {
    return IntroState(
      calculationMethods: calculationMethods ?? this.calculationMethods,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      madhab: madhab ?? this.madhab,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      isAddressFetching: isAddressFetching ?? this.isAddressFetching,
      isAddressFetched: isAddressFetched ?? this.isAddressFetched,
    );
  }

  @override
  List<Object> get props => [
        calculationMethods,
        calculationMethod,
        madhab,
        latitude,
        longitude,
        address,
        isAddressFetching,
        isAddressFetched,
      ];
}
