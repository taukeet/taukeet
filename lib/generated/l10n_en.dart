// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'taukeet';

  @override
  String get locationText => 'Location';

  @override
  String get locationIntro =>
      'Taukeet\'s accuracy in calculating and providing prayer times depends on your location. Please share your current location for precise results.';

  @override
  String get locationIntroNext =>
      'Thank you for the location, click on \"Next\" to continue';

  @override
  String get locationIntroBtn => 'Fetch location';

  @override
  String get locationIntroBtnLoading => 'Fetching location...';

  @override
  String get locationFetchNetworkFail =>
      'Failed to fetch location. Please check your network and try again.';

  @override
  String get madhabIntro =>
      'You can choose between Hanafi or Standard (Maliki, Shafi\'i, Hanbali) calculation methods for Asr prayer times. Hanafi starts Asr later when an object\'s shadow is twice its length.';

  @override
  String get madhabIntroBtn => 'Change madhab';

  @override
  String get calculationMethodIntro =>
      'The calculation methods are algorithms used to determine accurate prayer schedules. To begin, please select one that is near to your location or the one you prefer.';

  @override
  String get calculationMethodBtn => 'Change calculation method';

  @override
  String get disableLocationTitle => 'Warning';

  @override
  String get disableLocationMessage =>
      'Location is disabled, please enable to fetch the current location.';

  @override
  String get permissionErrorTitle => 'Permission Error';

  @override
  String get permissionErrorMessage =>
      'Taukeet needs location permission to fetch the current location, with current location Taukeet calculates the prayer times.';

  @override
  String get cancel => 'Cancel';

  @override
  String get openSettings => 'Open settings';

  @override
  String get loading => 'Loading...';

  @override
  String get settings => 'Settings';

  @override
  String get fetchLocationDesc => 'tap to get the current location';

  @override
  String get changeMadhabDesc => 'tap to change the madhab';

  @override
  String get changeCalculationMethodDesc =>
      'tap to change the calculation method';

  @override
  String get changeLattitudeSetting =>
      'In locations at higher latitude, twilight may persist throughout the night during some months of the year. In these abnormal periods, the determination of Fajr and Isha is not possible using the usual formulas, to overcome this problem, several solutions have been proposed, tap to change the method.';

  @override
  String get prayerSdjustments => 'Prayer adjustments';

  @override
  String get changeAdjustmentsDesc => 'Adjust the prayer times by minutes';

  @override
  String get changeLanguage => 'Change language';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Sunrise';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get reset => 'Reset';

  @override
  String get saveAdjustments => 'Save adjustments';

  @override
  String get adjustmentsSuccess => 'Adjustments saved successfully';

  @override
  String get adjustmentsResetSuccess => 'Adjustments reset successfully';

  @override
  String get muslimWorldLeague => 'Muslim World League';

  @override
  String get muslimWorldLeagueDesc =>
      'Muslim World League (MWL) method, usually used in Europe, Far East, and parts of America. Default in most calculators.';

  @override
  String get egyptian => 'Egyptian';

  @override
  String get egyptianDesc =>
      'Egyptian General Authority of Survey method, commonly used in Egypt.';

  @override
  String get karachi => 'Karachi';

  @override
  String get karachiDesc =>
      'University of Islamic Sciences, Karachi method, widely used in Karachi, Pakistan.';

  @override
  String get ummAlQura => 'Umm al-Qura';

  @override
  String get ummAlQuraDesc =>
      'Umm al-Qura University, Makkah method, utilized in Makkah, Saudi Arabia.';

  @override
  String get dubai => 'Dubai';

  @override
  String get dubaiDesc =>
      'Dubai method, specific to Dubai, United Arab Emirates.';

  @override
  String get moonsightingCommittee => 'Moonsighting Committee';

  @override
  String get moonsightingCommitteeDesc =>
      'Moonsighting Committee method, based on moonsighting observations.';

  @override
  String get northAmerica => 'North America';

  @override
  String get northAmericaDesc =>
      'Islamic Society of North America (ISNA) method, commonly used in North America.';

  @override
  String get kuwait => 'Kuwait';

  @override
  String get kuwaitDesc => 'Kuwait method, commonly used in Kuwait.';

  @override
  String get qatar => 'Qatar';

  @override
  String get qatarDesc => 'Qatar method, specific to Qatar.';

  @override
  String get singapore => 'Singapore';

  @override
  String get singaporeDesc => 'Singapore method, specific to Singapore.';

  @override
  String get turkey => 'Turkey';

  @override
  String get turkeyDesc => 'Turkey method, specific to Turkey.';

  @override
  String get tehran => 'Tehran';

  @override
  String get tehranDesc => 'Tehran method, specific to Tehran.';

  @override
  String get other => 'Other';

  @override
  String get otherDesc =>
      'Other or generic calculation method with no specific parameters.';

  @override
  String get none => 'None';

  @override
  String get noneDesc => 'No special latitude adjustment is applied.';

  @override
  String get middleOfTheNight => 'Middle of the Night';

  @override
  String get middleOfTheNightDesc =>
      'Fajr will never be earlier than the middle of the night and Isha will never be later than the middle of the night.';

  @override
  String get seventhOfTheNight => 'Seventh of the Night';

  @override
  String get seventhOfTheNightDesc =>
      'Fajr will never be earlier than the beginning of the last seventh of the night and Isha will never be later than the end of the first seventh of the night.';

  @override
  String get twilightAngle => 'Twilight Angle';

  @override
  String get twilightAngleDesc =>
      'Similar to Seventh of the Night, but instead of 1/7, the fraction of the night used is fajrAngle/60 and ishaAngle/60.';

  @override
  String get hanafi => 'Hanfi';

  @override
  String get hanafiDesc => 'Later Asr Time';

  @override
  String get shafi => 'Standard';

  @override
  String get shafiDesc => 'Malki, Shafi, Hanbali - Earlier Asr Time';
}
