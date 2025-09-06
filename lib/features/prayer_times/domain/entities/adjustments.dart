import 'dart:convert';

import 'package:equatable/equatable.dart';

class Adjustments extends Equatable {
  final int fajr;
  final int sunrise;
  final int dhuhr;
  final int asr;
  final int maghrib;
  final int isha;

  const Adjustments({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  Adjustments copyWith({
    int? fajr,
    int? sunrise,
    int? dhuhr,
    int? asr,
    int? maghrib,
    int? isha,
  }) =>
      Adjustments(
        fajr: fajr ?? this.fajr,
        sunrise: sunrise ?? this.sunrise,
        dhuhr: dhuhr ?? this.dhuhr,
        asr: asr ?? this.asr,
        maghrib: maghrib ?? this.maghrib,
        isha: isha ?? this.isha,
      );

  factory Adjustments.fromJson(String str) =>
      Adjustments.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Adjustments.fromMap(Map<String, dynamic> json) => Adjustments(
        fajr: json["fajr"],
        sunrise: json["sunrise"],
        dhuhr: json["dhuhr"],
        asr: json["asr"],
        maghrib: json["maghrib"],
        isha: json["isha"],
      );

  Map<String, dynamic> toMap() => {
        "fajr": fajr,
        "sunrise": sunrise,
        "dhuhr": dhuhr,
        "asr": asr,
        "maghrib": maghrib,
        "isha": isha,
      };

  @override
  List<Object> get props => [fajr, sunrise, dhuhr, asr, maghrib, isha];
}
