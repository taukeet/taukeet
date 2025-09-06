// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class SUr extends S {
  SUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'توقیت';

  @override
  String get locationText => 'مقام';

  @override
  String get locationIntro =>
      'نماز کے اوقات کی درستگی اور مہیا کرنے کے لیے توقیت کو آپ کے مقام کی ضرورت ہے۔ درست نتائج کے لیے براہ کرم اپنا موجودہ مقام شیئر کریں۔';

  @override
  String get locationIntroNext =>
      'مقام کا شکریہ، آگے بڑھنے کے لیے \"اگلا\" پر کلک کریں';

  @override
  String get locationIntroBtn => 'مقام حاصل کریں';

  @override
  String get locationIntroBtnLoading => 'مقام حاصل کیا جا رہا ہے...';

  @override
  String get locationFetchNetworkFail =>
      'مقام حاصل کرنے میں ناکامی۔ براہ کرم اپنا نیٹ ورک چیک کریں اور دوبارہ کوشش کریں۔';

  @override
  String get madhabIntro =>
      'آپ عصر کے وقت کے لیے حنفی یا معیاری (مالکی، شافعی، حنبلی) طریقہ کار میں سے انتخاب کر سکتے ہیں۔ حنفی میں عصر اس وقت شروع ہوتا ہے جب کسی شے کا سایہ اس کی لمبائی کے دوگنا ہو جائے۔';

  @override
  String get madhabIntroBtn => 'مذہب تبدیل کریں';

  @override
  String get calculationMethodIntro =>
      'حساب کے طریقے ایسے الگورتھمز ہیں جو درست نماز کے اوقات کے لیے استعمال ہوتے ہیں۔ شروع کرنے کے لیے وہ طریقہ منتخب کریں جو آپ کے مقام کے قریب ہو یا جو آپ ترجیح دیتے ہیں۔';

  @override
  String get calculationMethodBtn => 'طریقہ حساب تبدیل کریں';

  @override
  String get disableLocationTitle => 'خبردار';

  @override
  String get disableLocationMessage =>
      'مقام غیر فعال ہے، موجودہ مقام حاصل کرنے کے لیے اسے فعال کریں۔';

  @override
  String get permissionErrorTitle => 'اجازت کی خرابی';

  @override
  String get permissionErrorMessage =>
      'توقیت کو موجودہ مقام حاصل کرنے کے لیے مقام کی اجازت درکار ہے۔ موجودہ مقام کے ساتھ توقیت نماز کے اوقات کا حساب لگاتا ہے۔';

  @override
  String get cancel => 'منسوخ کریں';

  @override
  String get openSettings => 'ترتیبات کھولیں';

  @override
  String get loading => 'لوڈ ہو رہا ہے...';

  @override
  String get settings => 'ترتیبات';

  @override
  String get fetchLocationDesc => 'موجودہ مقام حاصل کرنے کے لیے ٹیپ کریں';

  @override
  String get changeMadhabDesc => 'مذہب تبدیل کرنے کے لیے ٹیپ کریں';

  @override
  String get changeCalculationMethodDesc =>
      'طریقہ حساب تبدیل کرنے کے لیے ٹیپ کریں';

  @override
  String get changeLattitudeSetting =>
      'اونچائی والے علاقوں میں، کچھ مہینوں میں رات کے دوران ٹوائلائٹ برقرار رہ سکتی ہے۔ ان غیر معمولی ادوار میں، فجر اور عشاء کا تعین معمول کے فارمولوں سے ممکن نہیں ہے۔ اس مسئلے سے نمٹنے کے لیے مختلف حل تجویز کیے گئے ہیں، طریقہ تبدیل کرنے کے لیے ٹیپ کریں۔';

  @override
  String get prayerSdjustments => 'نماز میں تبدیلیاں';

  @override
  String get changeAdjustmentsDesc =>
      'نماز کے اوقات میں منٹ کے حساب سے تبدیلی کریں';

  @override
  String get changeLanguage => 'زبان تبدیل کریں';

  @override
  String get fajr => 'فجر';

  @override
  String get sunrise => 'طلوع آفتاب';

  @override
  String get dhuhr => 'ظہر';

  @override
  String get asr => 'عصر';

  @override
  String get maghrib => 'مغرب';

  @override
  String get isha => 'عشاء';

  @override
  String get reset => 'ری سیٹ کریں';

  @override
  String get saveAdjustments => 'تبدیلیاں محفوظ کریں';

  @override
  String get adjustmentsSuccess => 'تبدیلیاں کامیابی کے ساتھ محفوظ ہو گئیں';

  @override
  String get adjustmentsResetSuccess =>
      'تبدیلیاں کامیابی کے ساتھ ری سیٹ ہو گئیں';

  @override
  String get muslimWorldLeague => 'مسلم ورلڈ لیگ';

  @override
  String get muslimWorldLeagueDesc =>
      'مسلم ورلڈ لیگ (MWL) طریقہ، عام طور پر یورپ، دورِ مشرق اور امریکہ کے کچھ حصوں میں استعمال ہوتا ہے۔ زیادہ تر کیلکولیٹرز میں ڈیفالٹ۔';

  @override
  String get egyptian => 'مصر';

  @override
  String get egyptianDesc =>
      'Egyptian General Authority of Survey طریقہ، عام طور پر مصر میں استعمال ہوتا ہے۔';

  @override
  String get karachi => 'کراچی';

  @override
  String get karachiDesc =>
      'University of Islamic Sciences, Karachi طریقہ، پاکستان میں کراچی میں وسیع پیمانے پر استعمال ہوتا ہے۔';

  @override
  String get ummAlQura => 'ام القریٰ';

  @override
  String get ummAlQuraDesc =>
      'Umm al-Qura University، مکہ طریقہ، سعودی عرب کے مکہ میں استعمال ہوتا ہے۔';

  @override
  String get dubai => 'دبئی';

  @override
  String get dubaiDesc => 'دبئی طریقہ، متحدہ عرب امارات کے دبئی کے لیے مخصوص۔';

  @override
  String get moonsightingCommittee => 'Moonsighting کمیٹی';

  @override
  String get moonsightingCommitteeDesc =>
      'Moonsighting کمیٹی طریقہ، چاند کے مشاہدات پر مبنی۔';

  @override
  String get northAmerica => 'شمالی امریکہ';

  @override
  String get northAmericaDesc =>
      'Islamic Society of North America (ISNA) طریقہ، عام طور پر شمالی امریکہ میں استعمال ہوتا ہے۔';

  @override
  String get kuwait => 'کویت';

  @override
  String get kuwaitDesc => 'کویت طریقہ، عام طور پر کویت میں استعمال ہوتا ہے۔';

  @override
  String get qatar => 'قطر';

  @override
  String get qatarDesc => 'قطر طریقہ، قطر کے لیے مخصوص۔';

  @override
  String get singapore => 'سنگاپور';

  @override
  String get singaporeDesc => 'سنگاپور طریقہ، سنگاپور کے لیے مخصوص۔';

  @override
  String get turkey => 'ترکی';

  @override
  String get turkeyDesc => 'ترکی طریقہ، ترکی کے لیے مخصوص۔';

  @override
  String get tehran => 'تہران';

  @override
  String get tehranDesc => 'تہران طریقہ، تہران کے لیے مخصوص۔';

  @override
  String get other => 'دیگر';

  @override
  String get otherDesc =>
      'دیگر یا عمومی حساب کا طریقہ بغیر کسی مخصوص پیرامیٹر کے۔';

  @override
  String get none => 'کوئی نہیں';

  @override
  String get noneDesc => 'کوئی خاص latitude adjustment لاگو نہیں۔';

  @override
  String get middleOfTheNight => 'رات کے درمیان';

  @override
  String get middleOfTheNightDesc =>
      'فجر کبھی رات کے درمیان سے پہلے نہیں ہوگی اور عشاء کبھی رات کے درمیان کے بعد نہیں ہوگی۔';

  @override
  String get seventhOfTheNight => 'رات کا ساتواں حصہ';

  @override
  String get seventhOfTheNightDesc =>
      'فجر کبھی رات کے آخری ساتویں حصہ کے شروع سے پہلے نہیں ہوگی اور عشاء کبھی پہلے ساتویں حصہ کے اختتام کے بعد نہیں ہوگی۔';

  @override
  String get twilightAngle => 'ٹائیلائٹ زاویہ';

  @override
  String get twilightAngleDesc =>
      'ساتویں حصے کے مماثل، لیکن 1/7 کی بجائے رات کا حصہ fajrAngle/60 اور ishaAngle/60 استعمال ہوتا ہے۔';

  @override
  String get hanafi => 'حنفی';

  @override
  String get hanafiDesc => 'بعد میں عصر کا وقت';

  @override
  String get shafi => 'معیاری';

  @override
  String get shafiDesc => 'مالکی، شافعی، حنبلی - جلدی عصر کا وقت';

  @override
  String get chooseLanguage => 'زبان منتخب کریں';

  @override
  String get chooseLanguageDesc => 'ایپ کے لیے اپنی پسندیدہ زبان منتخب کریں';

  @override
  String get chooseLanguageBtn => 'منتخب کریں';

  @override
  String get previous => 'پچھلا';

  @override
  String get next => 'آگے';

  @override
  String get done => 'مکمل';

  @override
  String get home => 'ہوم';

  @override
  String get qiblah => 'قبلہ';
}
