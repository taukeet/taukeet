// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "adjustmentsResetSuccess": MessageLookupByLibrary.simpleMessage(
      "Adjustments reset successfully",
    ),
    "adjustmentsSuccess": MessageLookupByLibrary.simpleMessage(
      "Adjustments saved successfully",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("taukeet"),
    "asr": MessageLookupByLibrary.simpleMessage("Asr"),
    "calculationMethodBtn": MessageLookupByLibrary.simpleMessage(
      "Change calculation method",
    ),
    "calculationMethodIntro": MessageLookupByLibrary.simpleMessage(
      "The calculation methods are algorithms used to determine accurate prayer schedules. To begin, please select one that is near to your location or the one you prefer.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "changeAdjustmentsDesc": MessageLookupByLibrary.simpleMessage(
      "Adjust the prayer times by minutes",
    ),
    "changeCalculationMethodDesc": MessageLookupByLibrary.simpleMessage(
      "tap to change the calculation method",
    ),
    "changeLanguage": MessageLookupByLibrary.simpleMessage("Change language"),
    "changeLattitudeSetting": MessageLookupByLibrary.simpleMessage(
      "In locations at higher latitude, twilight may persist throughout the night during some months of the year. In these abnormal periods, the determination of Fajr and Isha is not possible using the usual formulas, to overcome this problem, several solutions have been proposed, tap to change the method.",
    ),
    "changeMadhabDesc": MessageLookupByLibrary.simpleMessage(
      "tap to change the madhab",
    ),
    "chooseLanguage": MessageLookupByLibrary.simpleMessage("Choose Language"),
    "chooseLanguageBtn": MessageLookupByLibrary.simpleMessage("Select"),
    "chooseLanguageDesc": MessageLookupByLibrary.simpleMessage(
      "Select your preferred language for the app",
    ),
    "dhuhr": MessageLookupByLibrary.simpleMessage("Dhuhr"),
    "disableLocationMessage": MessageLookupByLibrary.simpleMessage(
      "Location is disabled, please enable to fetch the current location.",
    ),
    "disableLocationTitle": MessageLookupByLibrary.simpleMessage("Warning"),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "dubai": MessageLookupByLibrary.simpleMessage("Dubai"),
    "dubaiDesc": MessageLookupByLibrary.simpleMessage(
      "Dubai method, specific to Dubai, United Arab Emirates.",
    ),
    "egyptian": MessageLookupByLibrary.simpleMessage("Egyptian"),
    "egyptianDesc": MessageLookupByLibrary.simpleMessage(
      "Egyptian General Authority of Survey method, commonly used in Egypt.",
    ),
    "fajr": MessageLookupByLibrary.simpleMessage("Fajr"),
    "fetchLocationDesc": MessageLookupByLibrary.simpleMessage(
      "tap to get the current location",
    ),
    "hanafi": MessageLookupByLibrary.simpleMessage("Hanfi"),
    "hanafiDesc": MessageLookupByLibrary.simpleMessage("Later Asr Time"),
    "isha": MessageLookupByLibrary.simpleMessage("Isha"),
    "karachi": MessageLookupByLibrary.simpleMessage("Karachi"),
    "karachiDesc": MessageLookupByLibrary.simpleMessage(
      "University of Islamic Sciences, Karachi method, widely used in Karachi, Pakistan.",
    ),
    "kuwait": MessageLookupByLibrary.simpleMessage("Kuwait"),
    "kuwaitDesc": MessageLookupByLibrary.simpleMessage(
      "Kuwait method, commonly used in Kuwait.",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "locationFetchNetworkFail": MessageLookupByLibrary.simpleMessage(
      "Failed to fetch location. Please check your network and try again.",
    ),
    "locationIntro": MessageLookupByLibrary.simpleMessage(
      "Taukeet\'s accuracy in calculating and providing prayer times depends on your location. Please share your current location for precise results.",
    ),
    "locationIntroBtn": MessageLookupByLibrary.simpleMessage("Fetch location"),
    "locationIntroBtnLoading": MessageLookupByLibrary.simpleMessage(
      "Fetching location...",
    ),
    "locationIntroNext": MessageLookupByLibrary.simpleMessage(
      "Thank you for the location, click on \"Next\" to continue",
    ),
    "locationText": MessageLookupByLibrary.simpleMessage("Location"),
    "madhabIntro": MessageLookupByLibrary.simpleMessage(
      "You can choose between Hanafi or Standard (Maliki, Shafi\'i, Hanbali) calculation methods for Asr prayer times. Hanafi starts Asr later when an object\'s shadow is twice its length.",
    ),
    "madhabIntroBtn": MessageLookupByLibrary.simpleMessage("Change madhab"),
    "maghrib": MessageLookupByLibrary.simpleMessage("Maghrib"),
    "middleOfTheNight": MessageLookupByLibrary.simpleMessage(
      "Middle of the Night",
    ),
    "middleOfTheNightDesc": MessageLookupByLibrary.simpleMessage(
      "Fajr will never be earlier than the middle of the night and Isha will never be later than the middle of the night.",
    ),
    "moonsightingCommittee": MessageLookupByLibrary.simpleMessage(
      "Moonsighting Committee",
    ),
    "moonsightingCommitteeDesc": MessageLookupByLibrary.simpleMessage(
      "Moonsighting Committee method, based on moonsighting observations.",
    ),
    "muslimWorldLeague": MessageLookupByLibrary.simpleMessage(
      "Muslim World League",
    ),
    "muslimWorldLeagueDesc": MessageLookupByLibrary.simpleMessage(
      "Muslim World League (MWL) method, usually used in Europe, Far East, and parts of America. Default in most calculators.",
    ),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "none": MessageLookupByLibrary.simpleMessage("None"),
    "noneDesc": MessageLookupByLibrary.simpleMessage(
      "No special latitude adjustment is applied.",
    ),
    "northAmerica": MessageLookupByLibrary.simpleMessage("North America"),
    "northAmericaDesc": MessageLookupByLibrary.simpleMessage(
      "Islamic Society of North America (ISNA) method, commonly used in North America.",
    ),
    "openSettings": MessageLookupByLibrary.simpleMessage("Open settings"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "otherDesc": MessageLookupByLibrary.simpleMessage(
      "Other or generic calculation method with no specific parameters.",
    ),
    "permissionErrorMessage": MessageLookupByLibrary.simpleMessage(
      "Taukeet needs location permission to fetch the current location, with current location Taukeet calculates the prayer times.",
    ),
    "permissionErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Permission Error",
    ),
    "prayerSdjustments": MessageLookupByLibrary.simpleMessage(
      "Prayer adjustments",
    ),
    "previous": MessageLookupByLibrary.simpleMessage("Previous"),
    "qatar": MessageLookupByLibrary.simpleMessage("Qatar"),
    "qatarDesc": MessageLookupByLibrary.simpleMessage(
      "Qatar method, specific to Qatar.",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "saveAdjustments": MessageLookupByLibrary.simpleMessage("Save adjustments"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "seventhOfTheNight": MessageLookupByLibrary.simpleMessage(
      "Seventh of the Night",
    ),
    "seventhOfTheNightDesc": MessageLookupByLibrary.simpleMessage(
      "Fajr will never be earlier than the beginning of the last seventh of the night and Isha will never be later than the end of the first seventh of the night.",
    ),
    "shafi": MessageLookupByLibrary.simpleMessage("Standard"),
    "shafiDesc": MessageLookupByLibrary.simpleMessage(
      "Malki, Shafi, Hanbali - Earlier Asr Time",
    ),
    "singapore": MessageLookupByLibrary.simpleMessage("Singapore"),
    "singaporeDesc": MessageLookupByLibrary.simpleMessage(
      "Singapore method, specific to Singapore.",
    ),
    "sunrise": MessageLookupByLibrary.simpleMessage("Sunrise"),
    "tehran": MessageLookupByLibrary.simpleMessage("Tehran"),
    "tehranDesc": MessageLookupByLibrary.simpleMessage(
      "Tehran method, specific to Tehran.",
    ),
    "turkey": MessageLookupByLibrary.simpleMessage("Turkey"),
    "turkeyDesc": MessageLookupByLibrary.simpleMessage(
      "Turkey method, specific to Turkey.",
    ),
    "twilightAngle": MessageLookupByLibrary.simpleMessage("Twilight Angle"),
    "twilightAngleDesc": MessageLookupByLibrary.simpleMessage(
      "Similar to Seventh of the Night, but instead of 1/7, the fraction of the night used is fajrAngle/60 and ishaAngle/60.",
    ),
    "ummAlQura": MessageLookupByLibrary.simpleMessage("Umm al-Qura"),
    "ummAlQuraDesc": MessageLookupByLibrary.simpleMessage(
      "Umm al-Qura University, Makkah method, utilized in Makkah, Saudi Arabia.",
    ),
  };
}
