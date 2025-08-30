// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class SAr extends S {
  SAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'توقیت';

  @override
  String get locationText => 'الموقع';

  @override
  String get locationIntro =>
      'تعتمد دقة تطبيق تاوقت في حساب أوقات الصلاة على موقعك. يرجى مشاركة موقعك الحالي للحصول على نتائج دقيقة.';

  @override
  String get locationIntroNext => 'شكرًا لموقعك، اضغط على \"التالي\" للمتابعة';

  @override
  String get locationIntroBtn => 'جلب الموقع';

  @override
  String get locationIntroBtnLoading => 'جارٍ جلب الموقع...';

  @override
  String get locationFetchNetworkFail =>
      'فشل في جلب الموقع. يرجى التحقق من الشبكة والمحاولة مرة أخرى.';

  @override
  String get madhabIntro =>
      'يمكنك الاختيار بين المذهب الحنفي أو المعياري (مالكي، شافعي، حنبلي) لحساب وقت صلاة العصر. يبدأ الحنفية العصر لاحقًا عندما يكون ظل الجسم ضعف طوله.';

  @override
  String get madhabIntroBtn => 'تغيير المذهب';

  @override
  String get calculationMethodIntro =>
      'طرق الحساب هي خوارزميات تُستخدم لتحديد أوقات الصلاة بدقة. للبدء، يرجى اختيار الطريقة الأقرب إلى موقعك أو التي تفضلها.';

  @override
  String get calculationMethodBtn => 'تغيير طريقة الحساب';

  @override
  String get disableLocationTitle => 'تحذير';

  @override
  String get disableLocationMessage =>
      'الموقع معطل، يرجى تمكينه لجلب الموقع الحالي.';

  @override
  String get permissionErrorTitle => 'خطأ في الصلاحيات';

  @override
  String get permissionErrorMessage =>
      'تحتاج تطبيق تاوقت إلى إذن الموقع لجلب موقعك الحالي، حيث يحسب التطبيق أوقات الصلاة بناءً على موقعك.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get openSettings => 'افتح الإعدادات';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get settings => 'الإعدادات';

  @override
  String get fetchLocationDesc => 'اضغط للحصول على الموقع الحالي';

  @override
  String get changeMadhabDesc => 'اضغط لتغيير المذهب';

  @override
  String get changeCalculationMethodDesc => 'اضغط لتغيير طريقة الحساب';

  @override
  String get changeLattitudeSetting =>
      'في المواقع ذات خطوط العرض العالية، قد يستمر الشفق طوال الليل خلال بعض الأشهر. خلال هذه الفترات غير الطبيعية، لا يمكن تحديد وقتي الفجر والعشاء باستخدام الصيغ المعتادة. لتجاوز هذه المشكلة، تم اقتراح عدة حلول، اضغط لتغيير الطريقة.';

  @override
  String get prayerSdjustments => 'تعديلات الصلاة';

  @override
  String get changeAdjustmentsDesc => 'اضبط أوقات الصلاة بالدقائق';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get fajr => 'الفجر';

  @override
  String get sunrise => 'الشروق';

  @override
  String get dhuhr => 'الظهر';

  @override
  String get asr => 'العصر';

  @override
  String get maghrib => 'المغرب';

  @override
  String get isha => 'العشاء';

  @override
  String get reset => 'إعادة ضبط';

  @override
  String get saveAdjustments => 'حفظ التعديلات';

  @override
  String get adjustmentsSuccess => 'تم حفظ التعديلات بنجاح';

  @override
  String get adjustmentsResetSuccess => 'تمت إعادة ضبط التعديلات بنجاح';

  @override
  String get muslimWorldLeague => 'رابطة العالم الإسلامي';

  @override
  String get muslimWorldLeagueDesc =>
      'طريقة رابطة العالم الإسلامي (MWL)، تُستخدم عادة في أوروبا والشرق الأقصى وأجزاء من أمريكا. هي الافتراضية في معظم الحاسبات.';

  @override
  String get egyptian => 'المصرية';

  @override
  String get egyptianDesc =>
      'طريقة الهيئة العامة للمسح المصرية، تُستخدم غالبًا في مصر.';

  @override
  String get karachi => 'كراتشي';

  @override
  String get karachiDesc =>
      'طريقة جامعة العلوم الإسلامية بكراتشي، مستخدمة على نطاق واسع في كراتشي، باكستان.';

  @override
  String get ummAlQura => 'أم القرى';

  @override
  String get ummAlQuraDesc =>
      'طريقة جامعة أم القرى في مكة، مستخدمة في مكة، المملكة العربية السعودية.';

  @override
  String get dubai => 'دبي';

  @override
  String get dubaiDesc => 'طريقة دبي، خاصة بدبي، الإمارات العربية المتحدة.';

  @override
  String get moonsightingCommittee => 'لجنة رؤية الهلال';

  @override
  String get moonsightingCommitteeDesc =>
      'طريقة لجنة رؤية الهلال، تعتمد على ملاحظات الهلال.';

  @override
  String get northAmerica => 'أمريكا الشمالية';

  @override
  String get northAmericaDesc =>
      'طريقة الجمعية الإسلامية لأمريكا الشمالية (ISNA)، تُستخدم عادة في أمريكا الشمالية.';

  @override
  String get kuwait => 'الكويت';

  @override
  String get kuwaitDesc => 'طريقة الكويت، تُستخدم غالبًا في الكويت.';

  @override
  String get qatar => 'قطر';

  @override
  String get qatarDesc => 'طريقة قطر، خاصة بقطر.';

  @override
  String get singapore => 'سنغافورة';

  @override
  String get singaporeDesc => 'طريقة سنغافورة، خاصة بسنغافورة.';

  @override
  String get turkey => 'تركيا';

  @override
  String get turkeyDesc => 'طريقة تركيا، خاصة بتركيا.';

  @override
  String get tehran => 'طهران';

  @override
  String get tehranDesc => 'طريقة طهران، خاصة بطهران.';

  @override
  String get other => 'أخرى';

  @override
  String get otherDesc => 'طريقة حساب أخرى أو عامة بدون معايير محددة.';

  @override
  String get none => 'لا شيء';

  @override
  String get noneDesc => 'لا يتم تطبيق أي تعديل خاص بخط العرض.';

  @override
  String get middleOfTheNight => 'منتصف الليل';

  @override
  String get middleOfTheNightDesc =>
      'لن يكون الفجر قبل منتصف الليل ولن يكون العشاء بعد منتصف الليل.';

  @override
  String get seventhOfTheNight => 'السابع من الليل';

  @override
  String get seventhOfTheNightDesc =>
      'لن يكون الفجر قبل بداية السابع الأخير من الليل ولن يكون العشاء بعد نهاية السابع الأول من الليل.';

  @override
  String get twilightAngle => 'زاوية الشفق';

  @override
  String get twilightAngleDesc =>
      'مماثل للسابع من الليل، لكن بدل 1/7، يتم استخدام جزء الليل كـ fajrAngle/60 و ishaAngle/60.';

  @override
  String get hanafi => 'حنفي';

  @override
  String get hanafiDesc => 'وقت العصر متأخر';

  @override
  String get shafi => 'معياري';

  @override
  String get shafiDesc => 'مالكي، شافعي، حنبلي - وقت العصر مبكر';

  @override
  String get chooseLanguage => 'اختر اللغة';

  @override
  String get chooseLanguageDesc => 'اختر اللغة المفضلة للتطبيق';

  @override
  String get chooseLanguageBtn => 'اختر';

  @override
  String get previous => 'السابق';

  @override
  String get next => 'التالي';

  @override
  String get done => 'تم';
}
