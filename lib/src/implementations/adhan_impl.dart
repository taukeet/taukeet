import 'package:adhan/adhan.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_name.dart';
import 'package:taukeet/features/prayer_times/domain/entities/prayer_time.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';
import 'package:taukeet/core/utils/extensions.dart';

class AdhanImpl implements PrayerTimeService {
  final Map<String, dynamic> data;

  AdhanImpl({required this.data});

  final _prayerTimeMap = {
    Prayer.fajr: PrayerName(english: "Fajr", arabic: "فجر"),
    Prayer.sunrise: PrayerName(english: "Sunrise", arabic: "شروق"),
    Prayer.dhuhr: PrayerName(english: "Dhuhr", arabic: "ظهر"),
    Prayer.asr: PrayerName(english: "Asr", arabic: "عصر"),
    Prayer.maghrib: PrayerName(english: "Maghrib", arabic: "مغرب"),
    Prayer.isha: PrayerName(english: "Isha", arabic: "عشاء"),
  };

  late Address address;
  late Adjustments adjustments;
  late String calculationMethod;
  late String madhab;
  late String higherLatitude;

  @override
  List<String> get calculationMethods =>
      List<String>.from(data['methods'] as List);

  @override
  List<String> get higherLatitudes =>
      List<String>.from(data['latitudes'] as List);

  @override
  List<Map<String, String>> get madhabs => throw UnimplementedError();

  Madhab _madhab(String madhab) {
    switch (madhab) {
      case 'hanafi':
        return Madhab.hanafi;
      case 'shafi':
        return Madhab.shafi;
      default:
        return Madhab.hanafi;
    }
  }

  CalculationMethod _calculationMehod(String methodName) {
    switch (methodName) {
      case 'Dubai':
        return CalculationMethod.dubai;
      case 'Egyptian':
        return CalculationMethod.egyptian;
      case 'Karachi':
        return CalculationMethod.karachi;
      case 'Kuwait':
        return CalculationMethod.kuwait;
      case 'MoonsightingCommittee':
        return CalculationMethod.moon_sighting_committee;
      case 'MuslimWorldLeague':
        return CalculationMethod.muslim_world_league;
      case 'NorthAmerica':
        return CalculationMethod.north_america;
      case 'Qatar':
        return CalculationMethod.qatar;
      case 'Singapore':
        return CalculationMethod.singapore;
      case 'Tehran':
        return CalculationMethod.tehran;
      case 'Turkey':
        return CalculationMethod.turkey;
      case 'UmmAlQura':
        return CalculationMethod.umm_al_qura;
      default:
        return CalculationMethod
            .other; // Return 'Other' method if the provided method name is not found
    }
  }

  dynamic _higherLatitude(String latitudeName) {
    switch (latitudeName) {
      case 'MiddleOfTheNight':
        return HighLatitudeRule.middle_of_the_night;
      case 'SeventhOfTheNight':
        return HighLatitudeRule.seventh_of_the_night;
      case 'TwilightAngle':
        return HighLatitudeRule.twilight_angle;
      default:
        return null;
    }
  }

  PrayerTimes _calculatePrayertimes(DateTime dateTime) {
    Coordinates coordinates = Coordinates(address.latitude, address.longitude);
    CalculationParameters params =
        _calculationMehod(calculationMethod).getParameters();

    params.madhab = _madhab(madhab);

    params.adjustments.fajr = adjustments.fajr;
    params.adjustments.sunrise = adjustments.sunrise;
    params.adjustments.dhuhr = adjustments.dhuhr;
    params.adjustments.asr = adjustments.asr;
    params.adjustments.maghrib = adjustments.maghrib;
    params.adjustments.isha = adjustments.isha;

    final higherLatitude = _higherLatitude(this.higherLatitude);
    if (higherLatitude != null) {
      params.highLatitudeRule = higherLatitude;
    }

    return PrayerTimes(coordinates, DateComponents.from(dateTime), params);
  }

  @override
  void init(
    Address address,
    Adjustments adjustments,
    String calculationMethod,
    String madhab,
    String higherLatitude,
  ) {
    this.address = address;
    this.adjustments = adjustments;
    this.calculationMethod = calculationMethod;
    this.madhab = madhab;
    this.higherLatitude = higherLatitude;
  }

  @override
  PrayerTime currentPrayer() {
    PrayerTimes prayerTimes = _calculatePrayertimes(DateTime.now());
    Prayer prayer = prayerTimes.currentPrayer();

    if (prayer == Prayer.none) {
      prayer = Prayer.isha;
    }

    return PrayerTime(
      name: _prayerTimeMap[prayer]!,
      startTime: prayerTimes.timeForPrayer(prayer)!.toLocal(),
      isCurrentPrayer: false,
    );
  }

  @override
  List<PrayerTime> prayers(DateTime dateTime) {
    PrayerTimes prayerTimes = _calculatePrayertimes(dateTime);
    Prayer currentPrayer = prayerTimes.currentPrayer();

    if (currentPrayer == Prayer.none) {
      currentPrayer = Prayer.isha;
    }

    return _prayerTimeMap.keys.map((prayer) {
      return PrayerTime(
        name: _prayerTimeMap[prayer]!,
        startTime: prayerTimes.timeForPrayer(prayer)!.toLocal(),
        isCurrentPrayer: currentPrayer == prayer && dateTime.isToday(),
      );
    }).toList();
  }
}
