import 'package:adhan_dart/adhan_dart.dart';
import 'package:taukeet/main.dart';
import 'package:taukeet/src/entities/address.dart';
import 'package:taukeet/src/entities/prayer_name.dart';
import 'package:taukeet/src/entities/prayer_time.dart';
import 'package:taukeet/src/services/prayer_time_service.dart';

class AdhanImpl implements PrayerTimeService {
  final Map<String, dynamic> data;

  AdhanImpl({required this.data});

  final _prayerTimeMap = {
    Prayer.Fajr: PrayerName(english: "Fajr", arabic: "فجر"),
    Prayer.Sunrise: PrayerName(english: "Sunrise", arabic: "شروق"),
    Prayer.Dhuhr: PrayerName(english: "Dhuhr", arabic: "ظهر"),
    Prayer.Asr: PrayerName(english: "Asr", arabic: "عصر"),
    Prayer.Maghrib: PrayerName(english: "Maghrib", arabic: "مغرب"),
    Prayer.Isha: PrayerName(english: "Isha", arabic: "عشاء"),
  };

  late Address address;
  late String calculationMethod;
  late String madhab;

  @override
  List<Map<String, String>> get calculationMethods =>
      (data['methods'] as List<dynamic>)
          .map((item) => Map<String, String>.from(item))
          .toList();

  @override
  List<Map<String, String>> get higherLatitudes =>
      (data['latitudes'] as List<dynamic>)
          .map((item) => Map<String, String>.from(item))
          .toList();

  @override
  List<Map<String, String>> get madhabs => throw UnimplementedError();

  dynamic _calculationMehod(String methodName) {
    switch (methodName) {
      case 'Dubai':
        return CalculationMethod.Dubai();
      case 'Egyptian':
        return CalculationMethod.Egyptian();
      case 'Karachi':
        return CalculationMethod.Karachi();
      case 'Kuwait':
        return CalculationMethod.Kuwait();
      case 'Morocco':
        return CalculationMethod.Morocco();
      case 'MoonsightingCommittee':
        return CalculationMethod.MoonsightingCommittee();
      case 'MuslimWorldLeague':
        return CalculationMethod.MuslimWorldLeague();
      case 'NorthAmerica':
        return CalculationMethod.NorthAmerica();
      case 'Qatar':
        return CalculationMethod.Qatar();
      case 'Singapore':
        return CalculationMethod.Singapore();
      case 'Tehran':
        return CalculationMethod.Tehran();
      case 'Turkey':
        return CalculationMethod.Turkey();
      case 'UmmAlQura':
        return CalculationMethod.UmmAlQura();
      default:
        return CalculationMethod
            .Other(); // Return 'Other' method if the provided method name is not found
    }
  }

  dynamic _higherLatitude(String latitudeName) {
    switch (latitudeName) {
      case 'MiddleOfTheNight':
        return HighLatitudeRule.MiddleOfTheNight;
      case 'SeventhOfTheNight':
        return HighLatitudeRule.SeventhOfTheNight;
      case 'TwilightAngle':
        return HighLatitudeRule.TwilightAngle;
      default:
        return null;
    }
  }

  PrayerTimes _calculatePrayertimes(DateTime dateTime) {
    Coordinates coordinates = Coordinates(address.latitude, address.longitude);
    CalculationParameters params = _calculationMehod(calculationMethod);
    params.madhab = madhab;

    // final higherLatitude = _higherLatitude('None');
    // if (higherLatitude != null) {
    //   params.highLatitudeRule = higherLatitude;
    // }

    return PrayerTimes(coordinates, dateTime, params);
  }

  @override
  void init(
    Address address,
    String calculationMethod,
    String madhab,
  ) {
    this.address = address;
    this.calculationMethod = calculationMethod;
    this.madhab = madhab;
  }

  @override
  PrayerTime currentPrayer() {
    PrayerTimes prayerTimes = _calculatePrayertimes(DateTime.now());
    final prayer = prayerTimes.currentPrayer(date: DateTime.now());

    return PrayerTime(
      name: _prayerTimeMap[prayer]!,
      startTime: prayerTimes.timeForPrayer(prayer)!.toLocal(),
      isCurrentPrayer: false,
    );
  }

  @override
  List<PrayerTime> prayers(DateTime dateTime) {
    PrayerTimes prayerTimes = _calculatePrayertimes(dateTime);
    final currentPrayer = prayerTimes.currentPrayer(date: DateTime.now());

    return _prayerTimeMap.keys.map((prayer) {
      return PrayerTime(
        name: _prayerTimeMap[prayer]!,
        startTime: prayerTimes.timeForPrayer(prayer)!.toLocal(),
        isCurrentPrayer: currentPrayer == prayer && dateTime.isToday(),
      );
    }).toList();
  }
}
