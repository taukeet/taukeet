part of 'salah_cubit.dart';

@immutable
abstract class SalahState {
  List get salahList {
    return [
      "FAJAR",
      "SUNRISE",
      "DHUHR",
      "ASR",
      "MAGHRIB",
      "ISHA",
    ];
  }

  String get currentSalah {
    return "FAJAR";
  }
}

class SalahInitial extends SalahState {}
