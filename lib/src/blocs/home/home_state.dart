part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({required this.dateTime});

  final DateTime dateTime;

  HomeState copyWith({DateTime? dateTime}) {
    return HomeState(dateTime: dateTime ?? this.dateTime);
  }

  @override
  List<Object> get props => [dateTime];
}
