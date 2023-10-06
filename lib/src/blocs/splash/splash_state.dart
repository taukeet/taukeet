part of 'splash_cubit.dart';

class SplashState extends Equatable {
  const SplashState({
    required this.showNextButton,
  });

  final bool showNextButton;

  SplashState copyWith({
    bool? showNextButton,
  }) {
    return SplashState(
      showNextButton: showNextButton ?? this.showNextButton,
    );
  }

  @override
  List<Object> get props => [showNextButton];
}
