// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// L10nMapperGenerator
// **************************************************************************

import 'package:taukeet/generated/l10n.dart';
import 'package:flutter/widgets.dart';

extension BuildContextExtension on BuildContext {
  S get _localizations => S.of(this)!;
  S get l10n => _localizations;
  Locale get locale => Localizations.localeOf(this);
  String parseL10n(String translationKey, {List<Object>? arguments}) {
    final localizations = S.of(this)!;
    return L10nHelper.parseL10n(localizations, translationKey,
        arguments: arguments);
  }
}

extension SExtension on S {
  String parseL10n(String translationKey, {List<Object>? arguments}) {
    return L10nHelper.parseL10n(this, translationKey, arguments: arguments);
  }
}

class L10nHelper {
  static String parseL10n(S localizations, String translationKey,
      {List<Object>? arguments}) {
    const mapper = SMapper();
    final object = mapper.toLocalizationMap(localizations)[translationKey];
    if (object == null) return 'Translation key not found!';
    if (object is String) return object;
    assert(arguments != null, 'Arguments should not be null!');
    assert(arguments!.isNotEmpty, 'Arguments should not be empty!');
    return Function.apply(object, arguments);
  }
}

class SMapper {
  const SMapper();
  Map<String, dynamic> toLocalizationMap(S localizations) {
    return {
      'localeName': localizations.localeName,
      'appTitle': localizations.appTitle,
      'locationText': localizations.locationText,
      'locationIntro': localizations.locationIntro,
      'locationIntroNext': localizations.locationIntroNext,
      'locationIntroBtn': localizations.locationIntroBtn,
      'locationIntroBtnLoading': localizations.locationIntroBtnLoading,
      'locationFetchNetworkFail': localizations.locationFetchNetworkFail,
      'madhabIntro': localizations.madhabIntro,
      'madhabIntroBtn': localizations.madhabIntroBtn,
      'calculationMethodIntro': localizations.calculationMethodIntro,
      'calculationMethodBtn': localizations.calculationMethodBtn,
      'disableLocationTitle': localizations.disableLocationTitle,
      'disableLocationMessage': localizations.disableLocationMessage,
      'permissionErrorTitle': localizations.permissionErrorTitle,
      'permissionErrorMessage': localizations.permissionErrorMessage,
      'cancel': localizations.cancel,
      'openSettings': localizations.openSettings,
      'loading': localizations.loading,
      'settings': localizations.settings,
      'fetchLocationDesc': localizations.fetchLocationDesc,
      'changeMadhabDesc': localizations.changeMadhabDesc,
      'changeCalculationMethodDesc': localizations.changeCalculationMethodDesc,
      'changeLattitudeSetting': localizations.changeLattitudeSetting,
      'prayerSdjustments': localizations.prayerSdjustments,
      'changeAdjustmentsDesc': localizations.changeAdjustmentsDesc,
      'changeLanguage': localizations.changeLanguage,
      'fajr': localizations.fajr,
      'sunrise': localizations.sunrise,
      'dhuhr': localizations.dhuhr,
      'asr': localizations.asr,
      'maghrib': localizations.maghrib,
      'isha': localizations.isha,
      'reset': localizations.reset,
      'saveAdjustments': localizations.saveAdjustments,
      'adjustmentsSuccess': localizations.adjustmentsSuccess,
      'adjustmentsResetSuccess': localizations.adjustmentsResetSuccess,
      'muslimWorldLeague': localizations.muslimWorldLeague,
      'muslimWorldLeagueDesc': localizations.muslimWorldLeagueDesc,
      'egyptian': localizations.egyptian,
      'egyptianDesc': localizations.egyptianDesc,
      'karachi': localizations.karachi,
      'karachiDesc': localizations.karachiDesc,
      'ummAlQura': localizations.ummAlQura,
      'ummAlQuraDesc': localizations.ummAlQuraDesc,
      'dubai': localizations.dubai,
      'dubaiDesc': localizations.dubaiDesc,
      'moonsightingCommittee': localizations.moonsightingCommittee,
      'moonsightingCommitteeDesc': localizations.moonsightingCommitteeDesc,
      'northAmerica': localizations.northAmerica,
      'northAmericaDesc': localizations.northAmericaDesc,
      'kuwait': localizations.kuwait,
      'kuwaitDesc': localizations.kuwaitDesc,
      'qatar': localizations.qatar,
      'qatarDesc': localizations.qatarDesc,
      'singapore': localizations.singapore,
      'singaporeDesc': localizations.singaporeDesc,
      'turkey': localizations.turkey,
      'turkeyDesc': localizations.turkeyDesc,
      'tehran': localizations.tehran,
      'tehranDesc': localizations.tehranDesc,
      'other': localizations.other,
      'otherDesc': localizations.otherDesc,
      'none': localizations.none,
      'noneDesc': localizations.noneDesc,
      'middleOfTheNight': localizations.middleOfTheNight,
      'middleOfTheNightDesc': localizations.middleOfTheNightDesc,
      'seventhOfTheNight': localizations.seventhOfTheNight,
      'seventhOfTheNightDesc': localizations.seventhOfTheNightDesc,
      'twilightAngle': localizations.twilightAngle,
      'twilightAngleDesc': localizations.twilightAngleDesc,
      'hanafi': localizations.hanafi,
      'hanafiDesc': localizations.hanafiDesc,
      'shafi': localizations.shafi,
      'shafiDesc': localizations.shafiDesc,
      'chooseLanguage': localizations.chooseLanguage,
      'chooseLanguageDesc': localizations.chooseLanguageDesc,
      'chooseLanguageBtn': localizations.chooseLanguageBtn,
    };
  }
}
