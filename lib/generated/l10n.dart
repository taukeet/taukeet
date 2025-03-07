// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `taukeet`
  String get appTitle {
    return Intl.message('taukeet', name: 'appTitle', desc: '', args: []);
  }

  /// `Location`
  String get locationText {
    return Intl.message('Location', name: 'locationText', desc: '', args: []);
  }

  /// `Taukeet's accuracy in calculating and providing prayer times depends on your location. Please share your current location for precise results.`
  String get locationIntro {
    return Intl.message(
      'Taukeet\'s accuracy in calculating and providing prayer times depends on your location. Please share your current location for precise results.',
      name: 'locationIntro',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for the location, click on "Next" to continue`
  String get locationIntroNext {
    return Intl.message(
      'Thank you for the location, click on "Next" to continue',
      name: 'locationIntroNext',
      desc: '',
      args: [],
    );
  }

  /// `Fetch location`
  String get locationIntroBtn {
    return Intl.message(
      'Fetch location',
      name: 'locationIntroBtn',
      desc: '',
      args: [],
    );
  }

  /// `Fetching location...`
  String get locationIntroBtnLoading {
    return Intl.message(
      'Fetching location...',
      name: 'locationIntroBtnLoading',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch location. Please check your network and try again.`
  String get locationFetchNetworkFail {
    return Intl.message(
      'Failed to fetch location. Please check your network and try again.',
      name: 'locationFetchNetworkFail',
      desc: '',
      args: [],
    );
  }

  /// `You can choose between Hanafi or Standard (Maliki, Shafi'i, Hanbali) calculation methods for Asr prayer times. Hanafi starts Asr later when an object's shadow is twice its length.`
  String get madhabIntro {
    return Intl.message(
      'You can choose between Hanafi or Standard (Maliki, Shafi\'i, Hanbali) calculation methods for Asr prayer times. Hanafi starts Asr later when an object\'s shadow is twice its length.',
      name: 'madhabIntro',
      desc: '',
      args: [],
    );
  }

  /// `Change madhab`
  String get madhabIntroBtn {
    return Intl.message(
      'Change madhab',
      name: 'madhabIntroBtn',
      desc: '',
      args: [],
    );
  }

  /// `The calculation methods are algorithms used to determine accurate prayer schedules. To begin, please select one that is near to your location or the one you prefer.`
  String get calculationMethodIntro {
    return Intl.message(
      'The calculation methods are algorithms used to determine accurate prayer schedules. To begin, please select one that is near to your location or the one you prefer.',
      name: 'calculationMethodIntro',
      desc: '',
      args: [],
    );
  }

  /// `Change calculation method`
  String get calculationMethodBtn {
    return Intl.message(
      'Change calculation method',
      name: 'calculationMethodBtn',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get disableLocationTitle {
    return Intl.message(
      'Warning',
      name: 'disableLocationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Location is disabled, please enable to fetch the current location.`
  String get disableLocationMessage {
    return Intl.message(
      'Location is disabled, please enable to fetch the current location.',
      name: 'disableLocationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Permission Error`
  String get permissionErrorTitle {
    return Intl.message(
      'Permission Error',
      name: 'permissionErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Taukeet needs location permission to fetch the current location, with current location Taukeet calculates the prayer times.`
  String get permissionErrorMessage {
    return Intl.message(
      'Taukeet needs location permission to fetch the current location, with current location Taukeet calculates the prayer times.',
      name: 'permissionErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Open settings`
  String get openSettings {
    return Intl.message(
      'Open settings',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `tap to get the current location`
  String get fetchLocationDesc {
    return Intl.message(
      'tap to get the current location',
      name: 'fetchLocationDesc',
      desc: '',
      args: [],
    );
  }

  /// `tap to change the madhab`
  String get changeMadhabDesc {
    return Intl.message(
      'tap to change the madhab',
      name: 'changeMadhabDesc',
      desc: '',
      args: [],
    );
  }

  /// `tap to change the calculation method`
  String get changeCalculationMethodDesc {
    return Intl.message(
      'tap to change the calculation method',
      name: 'changeCalculationMethodDesc',
      desc: '',
      args: [],
    );
  }

  /// `In locations at higher latitude, twilight may persist throughout the night during some months of the year. In these abnormal periods, the determination of Fajr and Isha is not possible using the usual formulas, to overcome this problem, several solutions have been proposed, tap to change the method.`
  String get changeLattitudeSetting {
    return Intl.message(
      'In locations at higher latitude, twilight may persist throughout the night during some months of the year. In these abnormal periods, the determination of Fajr and Isha is not possible using the usual formulas, to overcome this problem, several solutions have been proposed, tap to change the method.',
      name: 'changeLattitudeSetting',
      desc: '',
      args: [],
    );
  }

  /// `Prayer adjustments`
  String get prayerSdjustments {
    return Intl.message(
      'Prayer adjustments',
      name: 'prayerSdjustments',
      desc: '',
      args: [],
    );
  }

  /// `Adjust the prayer times by minutes`
  String get changeAdjustmentsDesc {
    return Intl.message(
      'Adjust the prayer times by minutes',
      name: 'changeAdjustmentsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Fajr`
  String get fajr {
    return Intl.message('Fajr', name: 'fajr', desc: '', args: []);
  }

  /// `Sunrise`
  String get sunrise {
    return Intl.message('Sunrise', name: 'sunrise', desc: '', args: []);
  }

  /// `Dhuhr`
  String get dhuhr {
    return Intl.message('Dhuhr', name: 'dhuhr', desc: '', args: []);
  }

  /// `Asr`
  String get asr {
    return Intl.message('Asr', name: 'asr', desc: '', args: []);
  }

  /// `Maghrib`
  String get maghrib {
    return Intl.message('Maghrib', name: 'maghrib', desc: '', args: []);
  }

  /// `Isha`
  String get isha {
    return Intl.message('Isha', name: 'isha', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Save adjustments`
  String get saveAdjustments {
    return Intl.message(
      'Save adjustments',
      name: 'saveAdjustments',
      desc: '',
      args: [],
    );
  }

  /// `Adjustments saved successfully`
  String get adjustmentsSuccess {
    return Intl.message(
      'Adjustments saved successfully',
      name: 'adjustmentsSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Adjustments reset successfully`
  String get adjustmentsResetSuccess {
    return Intl.message(
      'Adjustments reset successfully',
      name: 'adjustmentsResetSuccess',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
