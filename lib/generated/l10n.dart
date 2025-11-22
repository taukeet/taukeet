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

  /// `Change language`
  String get changeLanguage {
    return Intl.message(
      'Change language',
      name: 'changeLanguage',
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

  /// `Muslim World League`
  String get muslimWorldLeague {
    return Intl.message(
      'Muslim World League',
      name: 'muslimWorldLeague',
      desc: '',
      args: [],
    );
  }

  /// `Muslim World League (MWL) method, usually used in Europe, Far East, and parts of America. Default in most calculators.`
  String get muslimWorldLeagueDesc {
    return Intl.message(
      'Muslim World League (MWL) method, usually used in Europe, Far East, and parts of America. Default in most calculators.',
      name: 'muslimWorldLeagueDesc',
      desc: '',
      args: [],
    );
  }

  /// `Egyptian`
  String get egyptian {
    return Intl.message('Egyptian', name: 'egyptian', desc: '', args: []);
  }

  /// `Egyptian General Authority of Survey method, commonly used in Egypt.`
  String get egyptianDesc {
    return Intl.message(
      'Egyptian General Authority of Survey method, commonly used in Egypt.',
      name: 'egyptianDesc',
      desc: '',
      args: [],
    );
  }

  /// `Karachi`
  String get karachi {
    return Intl.message('Karachi', name: 'karachi', desc: '', args: []);
  }

  /// `University of Islamic Sciences, Karachi method, widely used in Karachi, Pakistan.`
  String get karachiDesc {
    return Intl.message(
      'University of Islamic Sciences, Karachi method, widely used in Karachi, Pakistan.',
      name: 'karachiDesc',
      desc: '',
      args: [],
    );
  }

  /// `Umm al-Qura`
  String get ummAlQura {
    return Intl.message('Umm al-Qura', name: 'ummAlQura', desc: '', args: []);
  }

  /// `Umm al-Qura University, Makkah method, utilized in Makkah, Saudi Arabia.`
  String get ummAlQuraDesc {
    return Intl.message(
      'Umm al-Qura University, Makkah method, utilized in Makkah, Saudi Arabia.',
      name: 'ummAlQuraDesc',
      desc: '',
      args: [],
    );
  }

  /// `Dubai`
  String get dubai {
    return Intl.message('Dubai', name: 'dubai', desc: '', args: []);
  }

  /// `Dubai method, specific to Dubai, United Arab Emirates.`
  String get dubaiDesc {
    return Intl.message(
      'Dubai method, specific to Dubai, United Arab Emirates.',
      name: 'dubaiDesc',
      desc: '',
      args: [],
    );
  }

  /// `Moonsighting Committee`
  String get moonsightingCommittee {
    return Intl.message(
      'Moonsighting Committee',
      name: 'moonsightingCommittee',
      desc: '',
      args: [],
    );
  }

  /// `Moonsighting Committee method, based on moonsighting observations.`
  String get moonsightingCommitteeDesc {
    return Intl.message(
      'Moonsighting Committee method, based on moonsighting observations.',
      name: 'moonsightingCommitteeDesc',
      desc: '',
      args: [],
    );
  }

  /// `North America`
  String get northAmerica {
    return Intl.message(
      'North America',
      name: 'northAmerica',
      desc: '',
      args: [],
    );
  }

  /// `Islamic Society of North America (ISNA) method, commonly used in North America.`
  String get northAmericaDesc {
    return Intl.message(
      'Islamic Society of North America (ISNA) method, commonly used in North America.',
      name: 'northAmericaDesc',
      desc: '',
      args: [],
    );
  }

  /// `Kuwait`
  String get kuwait {
    return Intl.message('Kuwait', name: 'kuwait', desc: '', args: []);
  }

  /// `Kuwait method, commonly used in Kuwait.`
  String get kuwaitDesc {
    return Intl.message(
      'Kuwait method, commonly used in Kuwait.',
      name: 'kuwaitDesc',
      desc: '',
      args: [],
    );
  }

  /// `Qatar`
  String get qatar {
    return Intl.message('Qatar', name: 'qatar', desc: '', args: []);
  }

  /// `Qatar method, specific to Qatar.`
  String get qatarDesc {
    return Intl.message(
      'Qatar method, specific to Qatar.',
      name: 'qatarDesc',
      desc: '',
      args: [],
    );
  }

  /// `Singapore`
  String get singapore {
    return Intl.message('Singapore', name: 'singapore', desc: '', args: []);
  }

  /// `Singapore method, specific to Singapore.`
  String get singaporeDesc {
    return Intl.message(
      'Singapore method, specific to Singapore.',
      name: 'singaporeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Turkey`
  String get turkey {
    return Intl.message('Turkey', name: 'turkey', desc: '', args: []);
  }

  /// `Turkey method, specific to Turkey.`
  String get turkeyDesc {
    return Intl.message(
      'Turkey method, specific to Turkey.',
      name: 'turkeyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Tehran`
  String get tehran {
    return Intl.message('Tehran', name: 'tehran', desc: '', args: []);
  }

  /// `Tehran method, specific to Tehran.`
  String get tehranDesc {
    return Intl.message(
      'Tehran method, specific to Tehran.',
      name: 'tehranDesc',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Other or generic calculation method with no specific parameters.`
  String get otherDesc {
    return Intl.message(
      'Other or generic calculation method with no specific parameters.',
      name: 'otherDesc',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message('None', name: 'none', desc: '', args: []);
  }

  /// `No special latitude adjustment is applied.`
  String get noneDesc {
    return Intl.message(
      'No special latitude adjustment is applied.',
      name: 'noneDesc',
      desc: '',
      args: [],
    );
  }

  /// `Middle of the Night`
  String get middleOfTheNight {
    return Intl.message(
      'Middle of the Night',
      name: 'middleOfTheNight',
      desc: '',
      args: [],
    );
  }

  /// `Fajr will never be earlier than the middle of the night and Isha will never be later than the middle of the night.`
  String get middleOfTheNightDesc {
    return Intl.message(
      'Fajr will never be earlier than the middle of the night and Isha will never be later than the middle of the night.',
      name: 'middleOfTheNightDesc',
      desc: '',
      args: [],
    );
  }

  /// `Seventh of the Night`
  String get seventhOfTheNight {
    return Intl.message(
      'Seventh of the Night',
      name: 'seventhOfTheNight',
      desc: '',
      args: [],
    );
  }

  /// `Fajr will never be earlier than the beginning of the last seventh of the night and Isha will never be later than the end of the first seventh of the night.`
  String get seventhOfTheNightDesc {
    return Intl.message(
      'Fajr will never be earlier than the beginning of the last seventh of the night and Isha will never be later than the end of the first seventh of the night.',
      name: 'seventhOfTheNightDesc',
      desc: '',
      args: [],
    );
  }

  /// `Twilight Angle`
  String get twilightAngle {
    return Intl.message(
      'Twilight Angle',
      name: 'twilightAngle',
      desc: '',
      args: [],
    );
  }

  /// `Similar to Seventh of the Night, but instead of 1/7, the fraction of the night used is fajrAngle/60 and ishaAngle/60.`
  String get twilightAngleDesc {
    return Intl.message(
      'Similar to Seventh of the Night, but instead of 1/7, the fraction of the night used is fajrAngle/60 and ishaAngle/60.',
      name: 'twilightAngleDesc',
      desc: '',
      args: [],
    );
  }

  /// `Hanfi`
  String get hanafi {
    return Intl.message('Hanfi', name: 'hanafi', desc: '', args: []);
  }

  /// `Later Asr Time`
  String get hanafiDesc {
    return Intl.message(
      'Later Asr Time',
      name: 'hanafiDesc',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get shafi {
    return Intl.message('Standard', name: 'shafi', desc: '', args: []);
  }

  /// `Malki, Shafi, Hanbali - Earlier Asr Time`
  String get shafiDesc {
    return Intl.message(
      'Malki, Shafi, Hanbali - Earlier Asr Time',
      name: 'shafiDesc',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get chooseLanguage {
    return Intl.message(
      'Choose Language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred language for the app`
  String get chooseLanguageDesc {
    return Intl.message(
      'Select your preferred language for the app',
      name: 'chooseLanguageDesc',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get chooseLanguageBtn {
    return Intl.message(
      'Select',
      name: 'chooseLanguageBtn',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Qiblah`
  String get qiblah {
    return Intl.message('Qiblah', name: 'qiblah', desc: '', args: []);
  }

  /// `Current Location`
  String get qiblahCurrentLocation {
    return Intl.message(
      'Current Location',
      name: 'qiblahCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Lat: {lat}, Long: {long}`
  String qiblahLatLong(Object lat, Object long) {
    return Intl.message(
      'Lat: $lat, Long: $long',
      name: 'qiblahLatLong',
      desc: '',
      args: [lat, long],
    );
  }

  /// `Location not set`
  String get qiblahLocationNotSet {
    return Intl.message(
      'Location not set',
      name: 'qiblahLocationNotSet',
      desc: '',
      args: [],
    );
  }

  /// `Update Location`
  String get qiblahUpdateLocation {
    return Intl.message(
      'Update Location',
      name: 'qiblahUpdateLocation',
      desc: '',
      args: [],
    );
  }

  /// `Calculating Qiblah direction...`
  String get qiblahCalculating {
    return Intl.message(
      'Calculating Qiblah direction...',
      name: 'qiblahCalculating',
      desc: '',
      args: [],
    );
  }

  /// `Qiblah Direction will be displayed here`
  String get qiblahDirectionHere {
    return Intl.message(
      'Qiblah Direction will be displayed here',
      name: 'qiblahDirectionHere',
      desc: '',
      args: [],
    );
  }

  /// `Compass Calibration`
  String get qiblahCompassCalibration {
    return Intl.message(
      'Compass Calibration',
      name: 'qiblahCompassCalibration',
      desc: '',
      args: [],
    );
  }

  /// `Your compass needs calibration for accurate Qiblah direction.`
  String get qiblahCompassCalibrationMessage {
    return Intl.message(
      'Your compass needs calibration for accurate Qiblah direction.',
      name: 'qiblahCompassCalibrationMessage',
      desc: '',
      args: [],
    );
  }

  /// `How to Calibrate:`
  String get qiblahCompassHowToCalibrate {
    return Intl.message(
      'How to Calibrate:',
      name: 'qiblahCompassHowToCalibrate',
      desc: '',
      args: [],
    );
  }

  /// `1. Hold your phone firmly`
  String get qiblahCompassCalibrationStep1 {
    return Intl.message(
      '1. Hold your phone firmly',
      name: 'qiblahCompassCalibrationStep1',
      desc: '',
      args: [],
    );
  }

  /// `2. Move it in a figure-8 pattern in the air`
  String get qiblahCompassCalibrationStep2 {
    return Intl.message(
      '2. Move it in a figure-8 pattern in the air',
      name: 'qiblahCompassCalibrationStep2',
      desc: '',
      args: [],
    );
  }

  /// `3. Repeat for 10-15 seconds`
  String get qiblahCompassCalibrationStep3 {
    return Intl.message(
      '3. Repeat for 10-15 seconds',
      name: 'qiblahCompassCalibrationStep3',
      desc: '',
      args: [],
    );
  }

  /// `4. Try different orientations`
  String get qiblahCompassCalibrationStep4 {
    return Intl.message(
      '4. Try different orientations',
      name: 'qiblahCompassCalibrationStep4',
      desc: '',
      args: [],
    );
  }

  /// `Move away from metal objects and electronic devices for better accuracy.`
  String get qiblahCompassCalibrationTip {
    return Intl.message(
      'Move away from metal objects and electronic devices for better accuracy.',
      name: 'qiblahCompassCalibrationTip',
      desc: '',
      args: [],
    );
  }

  /// `I'll Try Later`
  String get qiblahCompassCalibrationLater {
    return Intl.message(
      'I\'ll Try Later',
      name: 'qiblahCompassCalibrationLater',
      desc: '',
      args: [],
    );
  }

  /// `Got It!`
  String get qiblahCompassCalibrationGotIt {
    return Intl.message(
      'Got It!',
      name: 'qiblahCompassCalibrationGotIt',
      desc: '',
      args: [],
    );
  }

  /// `Qiblah Direction: {direction}°`
  String qiblahCompassDirection(Object direction) {
    return Intl.message(
      'Qiblah Direction: $direction°',
      name: 'qiblahCompassDirection',
      desc: '',
      args: [direction],
    );
  }

  /// `Facing Qiblah`
  String get qiblahCompassFacingQiblah {
    return Intl.message(
      'Facing Qiblah',
      name: 'qiblahCompassFacingQiblah',
      desc: '',
      args: [],
    );
  }

  /// `Turn to find Qiblah`
  String get qiblahCompassTurnToFindQiblah {
    return Intl.message(
      'Turn to find Qiblah',
      name: 'qiblahCompassTurnToFindQiblah',
      desc: '',
      args: [],
    );
  }

  /// `Current heading: {heading}°`
  String qiblahCompassCurrentHeading(Object heading) {
    return Intl.message(
      'Current heading: $heading°',
      name: 'qiblahCompassCurrentHeading',
      desc: '',
      args: [heading],
    );
  }

  /// `Qiblah direction: {direction}°`
  String qiblahCompassQiblahDirection(Object direction) {
    return Intl.message(
      'Qiblah direction: $direction°',
      name: 'qiblahCompassQiblahDirection',
      desc: '',
      args: [direction],
    );
  }

  /// `Difference: {difference}°`
  String qiblahCompassDifference(Object difference) {
    return Intl.message(
      'Difference: $difference°',
      name: 'qiblahCompassDifference',
      desc: '',
      args: [difference],
    );
  }

  /// `Compass accuracy: {accuracy}`
  String qiblahCompassAccuracy(Object accuracy) {
    return Intl.message(
      'Compass accuracy: $accuracy',
      name: 'qiblahCompassAccuracy',
      desc: '',
      args: [accuracy],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'ur'),
    ];
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
