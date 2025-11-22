import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_ar.dart';
import 'l10n_en.dart';
import 'l10n_hi.dart';
import 'l10n_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('hi'),
    Locale('ur')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'taukeet'**
  String get appTitle;

  /// No description provided for @locationText.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationText;

  /// No description provided for @locationIntro.
  ///
  /// In en, this message translates to:
  /// **'Taukeet\'s accuracy in calculating and providing prayer times depends on your location. Please share your current location for precise results.'**
  String get locationIntro;

  /// No description provided for @locationIntroNext.
  ///
  /// In en, this message translates to:
  /// **'Thank you for the location, click on \"Next\" to continue'**
  String get locationIntroNext;

  /// No description provided for @locationIntroBtn.
  ///
  /// In en, this message translates to:
  /// **'Fetch location'**
  String get locationIntroBtn;

  /// No description provided for @locationIntroBtnLoading.
  ///
  /// In en, this message translates to:
  /// **'Fetching location...'**
  String get locationIntroBtnLoading;

  /// No description provided for @locationFetchNetworkFail.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch location. Please check your network and try again.'**
  String get locationFetchNetworkFail;

  /// No description provided for @madhabIntro.
  ///
  /// In en, this message translates to:
  /// **'You can choose between Hanafi or Standard (Maliki, Shafi\'i, Hanbali) calculation methods for Asr prayer times. Hanafi starts Asr later when an object\'s shadow is twice its length.'**
  String get madhabIntro;

  /// No description provided for @madhabIntroBtn.
  ///
  /// In en, this message translates to:
  /// **'Change madhab'**
  String get madhabIntroBtn;

  /// No description provided for @calculationMethodIntro.
  ///
  /// In en, this message translates to:
  /// **'The calculation methods are algorithms used to determine accurate prayer schedules. To begin, please select one that is near to your location or the one you prefer.'**
  String get calculationMethodIntro;

  /// No description provided for @calculationMethodBtn.
  ///
  /// In en, this message translates to:
  /// **'Change calculation method'**
  String get calculationMethodBtn;

  /// No description provided for @disableLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get disableLocationTitle;

  /// No description provided for @disableLocationMessage.
  ///
  /// In en, this message translates to:
  /// **'Location is disabled, please enable to fetch the current location.'**
  String get disableLocationMessage;

  /// No description provided for @permissionErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Permission Error'**
  String get permissionErrorTitle;

  /// No description provided for @permissionErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Taukeet needs location permission to fetch the current location, with current location Taukeet calculates the prayer times.'**
  String get permissionErrorMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @fetchLocationDesc.
  ///
  /// In en, this message translates to:
  /// **'tap to get the current location'**
  String get fetchLocationDesc;

  /// No description provided for @changeMadhabDesc.
  ///
  /// In en, this message translates to:
  /// **'tap to change the madhab'**
  String get changeMadhabDesc;

  /// No description provided for @changeCalculationMethodDesc.
  ///
  /// In en, this message translates to:
  /// **'tap to change the calculation method'**
  String get changeCalculationMethodDesc;

  /// No description provided for @changeLattitudeSetting.
  ///
  /// In en, this message translates to:
  /// **'In locations at higher latitude, twilight may persist throughout the night during some months of the year. In these abnormal periods, the determination of Fajr and Isha is not possible using the usual formulas, to overcome this problem, several solutions have been proposed, tap to change the method.'**
  String get changeLattitudeSetting;

  /// No description provided for @prayerSdjustments.
  ///
  /// In en, this message translates to:
  /// **'Prayer adjustments'**
  String get prayerSdjustments;

  /// No description provided for @changeAdjustmentsDesc.
  ///
  /// In en, this message translates to:
  /// **'Adjust the prayer times by minutes'**
  String get changeAdjustmentsDesc;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @saveAdjustments.
  ///
  /// In en, this message translates to:
  /// **'Save adjustments'**
  String get saveAdjustments;

  /// No description provided for @adjustmentsSuccess.
  ///
  /// In en, this message translates to:
  /// **'Adjustments saved successfully'**
  String get adjustmentsSuccess;

  /// No description provided for @adjustmentsResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Adjustments reset successfully'**
  String get adjustmentsResetSuccess;

  /// No description provided for @muslimWorldLeague.
  ///
  /// In en, this message translates to:
  /// **'Muslim World League'**
  String get muslimWorldLeague;

  /// No description provided for @muslimWorldLeagueDesc.
  ///
  /// In en, this message translates to:
  /// **'Muslim World League (MWL) method, usually used in Europe, Far East, and parts of America. Default in most calculators.'**
  String get muslimWorldLeagueDesc;

  /// No description provided for @egyptian.
  ///
  /// In en, this message translates to:
  /// **'Egyptian'**
  String get egyptian;

  /// No description provided for @egyptianDesc.
  ///
  /// In en, this message translates to:
  /// **'Egyptian General Authority of Survey method, commonly used in Egypt.'**
  String get egyptianDesc;

  /// No description provided for @karachi.
  ///
  /// In en, this message translates to:
  /// **'Karachi'**
  String get karachi;

  /// No description provided for @karachiDesc.
  ///
  /// In en, this message translates to:
  /// **'University of Islamic Sciences, Karachi method, widely used in Karachi, Pakistan.'**
  String get karachiDesc;

  /// No description provided for @ummAlQura.
  ///
  /// In en, this message translates to:
  /// **'Umm al-Qura'**
  String get ummAlQura;

  /// No description provided for @ummAlQuraDesc.
  ///
  /// In en, this message translates to:
  /// **'Umm al-Qura University, Makkah method, utilized in Makkah, Saudi Arabia.'**
  String get ummAlQuraDesc;

  /// No description provided for @dubai.
  ///
  /// In en, this message translates to:
  /// **'Dubai'**
  String get dubai;

  /// No description provided for @dubaiDesc.
  ///
  /// In en, this message translates to:
  /// **'Dubai method, specific to Dubai, United Arab Emirates.'**
  String get dubaiDesc;

  /// No description provided for @moonsightingCommittee.
  ///
  /// In en, this message translates to:
  /// **'Moonsighting Committee'**
  String get moonsightingCommittee;

  /// No description provided for @moonsightingCommitteeDesc.
  ///
  /// In en, this message translates to:
  /// **'Moonsighting Committee method, based on moonsighting observations.'**
  String get moonsightingCommitteeDesc;

  /// No description provided for @northAmerica.
  ///
  /// In en, this message translates to:
  /// **'North America'**
  String get northAmerica;

  /// No description provided for @northAmericaDesc.
  ///
  /// In en, this message translates to:
  /// **'Islamic Society of North America (ISNA) method, commonly used in North America.'**
  String get northAmericaDesc;

  /// No description provided for @kuwait.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get kuwait;

  /// No description provided for @kuwaitDesc.
  ///
  /// In en, this message translates to:
  /// **'Kuwait method, commonly used in Kuwait.'**
  String get kuwaitDesc;

  /// No description provided for @qatar.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get qatar;

  /// No description provided for @qatarDesc.
  ///
  /// In en, this message translates to:
  /// **'Qatar method, specific to Qatar.'**
  String get qatarDesc;

  /// No description provided for @singapore.
  ///
  /// In en, this message translates to:
  /// **'Singapore'**
  String get singapore;

  /// No description provided for @singaporeDesc.
  ///
  /// In en, this message translates to:
  /// **'Singapore method, specific to Singapore.'**
  String get singaporeDesc;

  /// No description provided for @turkey.
  ///
  /// In en, this message translates to:
  /// **'Turkey'**
  String get turkey;

  /// No description provided for @turkeyDesc.
  ///
  /// In en, this message translates to:
  /// **'Turkey method, specific to Turkey.'**
  String get turkeyDesc;

  /// No description provided for @tehran.
  ///
  /// In en, this message translates to:
  /// **'Tehran'**
  String get tehran;

  /// No description provided for @tehranDesc.
  ///
  /// In en, this message translates to:
  /// **'Tehran method, specific to Tehran.'**
  String get tehranDesc;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @otherDesc.
  ///
  /// In en, this message translates to:
  /// **'Other or generic calculation method with no specific parameters.'**
  String get otherDesc;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @noneDesc.
  ///
  /// In en, this message translates to:
  /// **'No special latitude adjustment is applied.'**
  String get noneDesc;

  /// No description provided for @middleOfTheNight.
  ///
  /// In en, this message translates to:
  /// **'Middle of the Night'**
  String get middleOfTheNight;

  /// No description provided for @middleOfTheNightDesc.
  ///
  /// In en, this message translates to:
  /// **'Fajr will never be earlier than the middle of the night and Isha will never be later than the middle of the night.'**
  String get middleOfTheNightDesc;

  /// No description provided for @seventhOfTheNight.
  ///
  /// In en, this message translates to:
  /// **'Seventh of the Night'**
  String get seventhOfTheNight;

  /// No description provided for @seventhOfTheNightDesc.
  ///
  /// In en, this message translates to:
  /// **'Fajr will never be earlier than the beginning of the last seventh of the night and Isha will never be later than the end of the first seventh of the night.'**
  String get seventhOfTheNightDesc;

  /// No description provided for @twilightAngle.
  ///
  /// In en, this message translates to:
  /// **'Twilight Angle'**
  String get twilightAngle;

  /// No description provided for @twilightAngleDesc.
  ///
  /// In en, this message translates to:
  /// **'Similar to Seventh of the Night, but instead of 1/7, the fraction of the night used is fajrAngle/60 and ishaAngle/60.'**
  String get twilightAngleDesc;

  /// No description provided for @hanafi.
  ///
  /// In en, this message translates to:
  /// **'Hanfi'**
  String get hanafi;

  /// No description provided for @hanafiDesc.
  ///
  /// In en, this message translates to:
  /// **'Later Asr Time'**
  String get hanafiDesc;

  /// No description provided for @shafi.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get shafi;

  /// No description provided for @shafiDesc.
  ///
  /// In en, this message translates to:
  /// **'Malki, Shafi, Hanbali - Earlier Asr Time'**
  String get shafiDesc;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @chooseLanguageDesc.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language for the app'**
  String get chooseLanguageDesc;

  /// No description provided for @chooseLanguageBtn.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get chooseLanguageBtn;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @qiblah.
  ///
  /// In en, this message translates to:
  /// **'Qiblah'**
  String get qiblah;

  /// No description provided for @qiblahCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get qiblahCurrentLocation;

  /// No description provided for @qiblahLatLong.
  ///
  /// In en, this message translates to:
  /// **'Lat: {lat}, Long: {long}'**
  String qiblahLatLong(Object lat, Object long);

  /// No description provided for @qiblahLocationNotSet.
  ///
  /// In en, this message translates to:
  /// **'Location not set'**
  String get qiblahLocationNotSet;

  /// No description provided for @qiblahUpdateLocation.
  ///
  /// In en, this message translates to:
  /// **'Update Location'**
  String get qiblahUpdateLocation;

  /// No description provided for @qiblahCalculating.
  ///
  /// In en, this message translates to:
  /// **'Calculating Qiblah direction...'**
  String get qiblahCalculating;

  /// No description provided for @qiblahDirectionHere.
  ///
  /// In en, this message translates to:
  /// **'Qiblah Direction will be displayed here'**
  String get qiblahDirectionHere;

  /// No description provided for @qiblahCompassCalibration.
  ///
  /// In en, this message translates to:
  /// **'Compass Calibration'**
  String get qiblahCompassCalibration;

  /// No description provided for @qiblahCompassCalibrationMessage.
  ///
  /// In en, this message translates to:
  /// **'Your compass needs calibration for accurate Qiblah direction.'**
  String get qiblahCompassCalibrationMessage;

  /// No description provided for @qiblahCompassHowToCalibrate.
  ///
  /// In en, this message translates to:
  /// **'How to Calibrate:'**
  String get qiblahCompassHowToCalibrate;

  /// No description provided for @qiblahCompassCalibrationStep1.
  ///
  /// In en, this message translates to:
  /// **'1. Hold your phone firmly'**
  String get qiblahCompassCalibrationStep1;

  /// No description provided for @qiblahCompassCalibrationStep2.
  ///
  /// In en, this message translates to:
  /// **'2. Move it in a figure-8 pattern in the air'**
  String get qiblahCompassCalibrationStep2;

  /// No description provided for @qiblahCompassCalibrationStep3.
  ///
  /// In en, this message translates to:
  /// **'3. Repeat for 10-15 seconds'**
  String get qiblahCompassCalibrationStep3;

  /// No description provided for @qiblahCompassCalibrationStep4.
  ///
  /// In en, this message translates to:
  /// **'4. Try different orientations'**
  String get qiblahCompassCalibrationStep4;

  /// No description provided for @qiblahCompassCalibrationTip.
  ///
  /// In en, this message translates to:
  /// **'Move away from metal objects and electronic devices for better accuracy.'**
  String get qiblahCompassCalibrationTip;

  /// No description provided for @qiblahCompassCalibrationLater.
  ///
  /// In en, this message translates to:
  /// **'I\'ll Try Later'**
  String get qiblahCompassCalibrationLater;

  /// No description provided for @qiblahCompassCalibrationGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got It!'**
  String get qiblahCompassCalibrationGotIt;

  /// No description provided for @qiblahCompassDirection.
  ///
  /// In en, this message translates to:
  /// **'Qiblah Direction: {direction}°'**
  String qiblahCompassDirection(Object direction);

  /// No description provided for @qiblahCompassFacingQiblah.
  ///
  /// In en, this message translates to:
  /// **'Facing Qiblah'**
  String get qiblahCompassFacingQiblah;

  /// No description provided for @qiblahCompassTurnToFindQiblah.
  ///
  /// In en, this message translates to:
  /// **'Turn to find Qiblah'**
  String get qiblahCompassTurnToFindQiblah;

  /// No description provided for @qiblahCompassCurrentHeading.
  ///
  /// In en, this message translates to:
  /// **'Current heading: {heading}°'**
  String qiblahCompassCurrentHeading(Object heading);

  /// No description provided for @qiblahCompassQiblahDirection.
  ///
  /// In en, this message translates to:
  /// **'Qiblah direction: {direction}°'**
  String qiblahCompassQiblahDirection(Object direction);

  /// No description provided for @qiblahCompassDifference.
  ///
  /// In en, this message translates to:
  /// **'Difference: {difference}°'**
  String qiblahCompassDifference(Object difference);

  /// No description provided for @qiblahCompassAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Compass accuracy: {accuracy}'**
  String qiblahCompassAccuracy(Object accuracy);
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'hi', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return SAr();
    case 'en':
      return SEn();
    case 'hi':
      return SHi();
    case 'ur':
      return SUr();
  }

  throw FlutterError(
      'S.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
