part of 'intro_cubit.dart';

class IntroState extends Equatable {
  final List<CalculationMethod> calculationMethods;

  const IntroState({
    this.calculationMethods = const [],
  });

  IntroState copyWith({
    List<CalculationMethod>? calculationMethods,
  }) {
    return IntroState(
      calculationMethods: calculationMethods ?? this.calculationMethods,
    );
  }

  @override
  List<Object> get props => [];
}
