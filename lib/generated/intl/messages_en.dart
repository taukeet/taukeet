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
    "appTitle": MessageLookupByLibrary.simpleMessage("taukeet"),
    "calculationMethodBtn": MessageLookupByLibrary.simpleMessage(
      "Change calculation method",
    ),
    "calculationMethodIntro": MessageLookupByLibrary.simpleMessage(
      "The calculation methods are algorithms used to determine accurate prayer schedules. To begin, please select one that is near to your location or the one you prefer.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "disableLocationMessage": MessageLookupByLibrary.simpleMessage(
      "Location is disabled, please enable to fetch the current location.",
    ),
    "disableLocationTitle": MessageLookupByLibrary.simpleMessage("Warning"),
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
    "openSettings": MessageLookupByLibrary.simpleMessage("Open settings"),
    "permissionErrorMessage": MessageLookupByLibrary.simpleMessage(
      "Taukeet needs location permission to fetch the current location, with current location Taukeet calculates the prayer times.",
    ),
    "permissionErrorTitle": MessageLookupByLibrary.simpleMessage(
      "Permission Error",
    ),
  };
}
