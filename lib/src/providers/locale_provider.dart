import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taukeet/generated/l10n.dart';

class LocaleState {
  final Locale locale;
  final List<Locale> supportedLocales;

  LocaleState({
    required this.locale,
    required this.supportedLocales,
  });

  LocaleState copyWith({
    Locale? locale,
    List<Locale>? supportedLocales,
  }) {
    return LocaleState(
      locale: locale ?? this.locale,
      supportedLocales: supportedLocales ?? this.supportedLocales,
    );
  }
}

class LocaleNotifier extends StateNotifier<LocaleState> {
  LocaleNotifier()
      : super(
          LocaleState(
            locale: const Locale('en'),
            supportedLocales: S.delegate.supportedLocales,
          ),
        ) {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode') ?? 'en';
    state = state.copyWith(locale: Locale(languageCode));
  }

  Future<void> setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    state = state.copyWith(locale: locale);
  }
}

final localeProvider =
    StateNotifierProvider<LocaleNotifier, LocaleState>((ref) {
  return LocaleNotifier();
});
