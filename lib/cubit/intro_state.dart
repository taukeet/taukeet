part of 'intro_cubit.dart';

class IntroState extends Equatable {
  final List<CalculationMethod> calculationMethods;
  final String calculationMethod;
  final String madhab;

  const IntroState({
    this.calculationMethods = const [],
    this.calculationMethod = "muslim_world_league",
    this.madhab = "hanfi",
  });

  IntroState copyWith({
    List<CalculationMethod>? calculationMethods,
    String? calculationMethod,
    String? madhab,
  }) {
    return IntroState(
      calculationMethods: calculationMethods ?? this.calculationMethods,
      calculationMethod: calculationMethod ?? this.calculationMethod,
      madhab: madhab ?? this.madhab,
    );
  }

  @override
  List<Object> get props => [calculationMethods, calculationMethod, madhab];
}
