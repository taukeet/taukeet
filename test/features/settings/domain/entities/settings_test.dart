import 'package:flutter_test/flutter_test.dart';
import 'package:taukeet/features/location/domain/entities/address.dart';
import 'package:taukeet/features/prayer_times/domain/entities/adjustments.dart';
import 'package:taukeet/features/settings/domain/entities/settings.dart';

void main() {
  group('Settings', () {
    final tSettings = Settings(
      address: Address(
        latitude: 24.4667,
        longitude: 39.6,
        address: "Madina, Saudi Arabia",
      ),
      adjustments: Adjustments(
        fajr: 0,
        sunrise: 0,
        dhuhr: 0,
        asr: 0,
        maghrib: 0,
        isha: 0,
      ),
      madhab: "hanafi",
      calculationMethod: "Karachi",
      higherLatitude: "None",
      hasFetchedInitialLocation: false,
      isTutorialCompleted: false,
    );

    test('should support value equality', () {
      expect(
        tSettings,
        equals(
          Settings(
            address: Address(
              latitude: 24.4667,
              longitude: 39.6,
              address: "Madina, Saudi Arabia",
            ),
            adjustments: Adjustments(
              fajr: 0,
              sunrise: 0,
              dhuhr: 0,
              asr: 0,
              maghrib: 0,
              isha: 0,
            ),
            madhab: "hanafi",
            calculationMethod: "Karachi",
            higherLatitude: "None",
            hasFetchedInitialLocation: false,
            isTutorialCompleted: false,
          ),
        ),
      );
    });

    test('should have correct props', () {
      expect(tSettings.props, [
        tSettings.address,
        tSettings.adjustments,
        tSettings.madhab,
        tSettings.calculationMethod,
        tSettings.higherLatitude,
        tSettings.hasFetchedInitialLocation,
        tSettings.isTutorialCompleted,
      ]);
    });

    test('should create a Settings object with the given values', () {
      // assert
      expect(tSettings.address.latitude, 24.4667);
      expect(tSettings.address.longitude, 39.6);
      expect(tSettings.address.address, "Madina, Saudi Arabia");
      expect(tSettings.adjustments.fajr, 0);
      expect(tSettings.adjustments.sunrise, 0);
      expect(tSettings.adjustments.dhuhr, 0);
      expect(tSettings.adjustments.asr, 0);
      expect(tSettings.adjustments.maghrib, 0);
      expect(tSettings.adjustments.isha, 0);
      expect(tSettings.madhab, "hanafi");
      expect(tSettings.calculationMethod, "Karachi");
      expect(tSettings.higherLatitude, "None");
      expect(tSettings.hasFetchedInitialLocation, false);
      expect(tSettings.isTutorialCompleted, false);
    });

    test('should return a new Settings object with updated values', () {
      // arrange
      final newSettings = tSettings.copyWith(
        address: Address(
          latitude: 25.0,
          longitude: 40.0,
          address: "Makkah, Saudi Arabia",
        ),
        madhab: "shafi",
        isTutorialCompleted: true,
      );

      // assert
      expect(newSettings.address.latitude, 25.0);
      expect(newSettings.address.longitude, 40.0);
      expect(newSettings.address.address, "Makkah, Saudi Arabia");
      expect(newSettings.madhab, "shafi");
      expect(newSettings.isTutorialCompleted, true);
    });

    test('should convert to and from json', () {
      // act
      final json = tSettings.toJson();
      final fromJson = Settings.fromJson(json);
      // assert
      expect(fromJson, tSettings);
    });

    test('should convert to and from map', () {
      // act
      final map = tSettings.toMap();
      final fromMap = Settings.fromMap(map);
      // assert
      expect(fromMap, tSettings);
    });
  });
}
