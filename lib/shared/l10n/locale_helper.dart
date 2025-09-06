import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class LocaleHelper {
  static List<dynamic>? _locales;

  static Future<void> loadLocales() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/locales.json');

    _locales = jsonDecode(jsonString);
  }

  static Map<String, String>? getLocaleInfo(Locale locale) {
    if (_locales == null) return null;

    final result = _locales!
        .firstWhere((l) => l['code'] == locale.toString(), orElse: () => null);

    return result != null
        ? (result as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value.toString()))
        : null;
  }
}

extension LocaleExtensions on Locale {
  String? get fullName => LocaleHelper.getLocaleInfo(this)?['name'];
  String? get nativeName => LocaleHelper.getLocaleInfo(this)?['native'];
}
