// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class SHi extends S {
  SHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'तौकीत';

  @override
  String get locationText => 'स्थान';

  @override
  String get locationIntro =>
      'तौकीत की सटीकता प्रार्थना के समय की गणना और प्रदान करने में आपके स्थान पर निर्भर करती है। सटीक परिणामों के लिए कृपया अपना वर्तमान स्थान साझा करें।';

  @override
  String get locationIntroNext =>
      'स्थान के लिए धन्यवाद, जारी रखने के लिए \"अगला\" पर क्लिक करें';

  @override
  String get locationIntroBtn => 'स्थान प्राप्त करें';

  @override
  String get locationIntroBtnLoading => 'स्थान प्राप्त हो रहा है...';

  @override
  String get locationFetchNetworkFail =>
      'स्थान प्राप्त करने में विफल। कृपया अपना नेटवर्क जांचें और पुनः प्रयास करें।';

  @override
  String get madhabIntro =>
      'आप अस्र की नमाज़ के समय के लिए हनफ़ी या मानक (मलिकी, शफ़ीई, हंबली) गणना विधियों के बीच चयन कर सकते हैं। हनफ़ी अस्र तब शुरू होती है जब किसी वस्तु की छाया उसकी लंबाई से दोगुनी हो जाती है।';

  @override
  String get madhabIntroBtn => 'मज़हब बदलें';

  @override
  String get calculationMethodIntro =>
      'गणना विधियाँ सटीक प्रार्थना कार्यक्रम निर्धारित करने के लिए उपयोग किए जाने वाले एल्गोरिदम हैं। आरंभ करने के लिए, कृपया अपने स्थान के निकट या जिसे आप पसंद करते हैं, उसका चयन करें।';

  @override
  String get calculationMethodBtn => 'गणना विधि बदलें';

  @override
  String get disableLocationTitle => 'चेतावनी';

  @override
  String get disableLocationMessage =>
      'स्थान अक्षम है, कृपया वर्तमान स्थान प्राप्त करने के लिए सक्षम करें।';

  @override
  String get permissionErrorTitle => 'अनुमति त्रुटि';

  @override
  String get permissionErrorMessage =>
      'तौकीत को वर्तमान स्थान प्राप्त करने के लिए स्थान की अनुमति चाहिए, वर्तमान स्थान के साथ तौकीत प्रार्थना के समय की गणना करता है।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get fetchLocationDesc => 'वर्तमान स्थान प्राप्त करने के लिए टैप करें';

  @override
  String get changeMadhabDesc => 'मज़हब बदलने के लिए टैप करें';

  @override
  String get changeCalculationMethodDesc => 'गणना विधि बदलने के लिए टैप करें';

  @override
  String get changeLattitudeSetting =>
      'उच्च अक्षांश वाले स्थानों में, वर्ष के कुछ महीनों के दौरान रात भर गोधूलि बनी रह सकती है। इन असामान्य अवधियों में, सामान्य सूत्रों का उपयोग करके फज्र और ईशा का निर्धारण संभव नहीं है, इस समस्या को दूर करने के लिए, कई समाधान प्रस्तावित किए गए हैं, विधि बदलने के लिए टैप करें।';

  @override
  String get prayerSdjustments => 'प्रार्थना समायोजन';

  @override
  String get changeAdjustmentsDesc =>
      'प्रार्थना के समय को मिनटों में समायोजित करें';

  @override
  String get changeLanguage => 'भाषा बदलें';

  @override
  String get fajr => 'फज्र';

  @override
  String get sunrise => 'सूर्योदय';

  @override
  String get dhuhr => 'ज़ुहर';

  @override
  String get asr => 'अस्र';

  @override
  String get maghrib => 'मग़रिब';

  @override
  String get isha => 'ईशा';

  @override
  String get reset => 'रीसेट';

  @override
  String get saveAdjustments => 'समायोजन सहेजें';

  @override
  String get adjustmentsSuccess => 'समायोजन सफलतापूर्वक सहेजा गया';

  @override
  String get adjustmentsResetSuccess => 'समायोजन सफलतापूर्वक रीसेट किया गया';

  @override
  String get muslimWorldLeague => 'मुस्लिम वर्ल्ड लीग';

  @override
  String get muslimWorldLeagueDesc =>
      'मुस्लिम वर्ल्ड लीग (MWL) विधि, आमतौर पर यूरोप, सुदूर पूर्व और अमेरिका के कुछ हिस्सों में उपयोग की जाती है। अधिकांश कैलकुलेटर में डिफ़ॉल्ट विधि है।';

  @override
  String get egyptian => 'मिस्री';

  @override
  String get egyptianDesc =>
      'मिस्र की जनरल अथॉरिटी ऑफ सर्वे विधि, जो मिस्र में सामान्य रूप से उपयोग की जाती है।';

  @override
  String get karachi => 'कराची';

  @override
  String get karachiDesc =>
      'इस्लामिक साइंसेज़ विश्वविद्यालय, कराची की विधि, जो कराची, पाकिस्तान में व्यापक रूप से उपयोग होती है।';

  @override
  String get ummAlQura => 'उम्म अल-क़ुरा';

  @override
  String get ummAlQuraDesc =>
      'उम्म अल-क़ुरा विश्वविद्यालय, मक्का की विधि, जो मक्का, सऊदी अरब में उपयोग की जाती है।';

  @override
  String get dubai => 'दुबई';

  @override
  String get dubaiDesc =>
      'दुबई विधि, विशेष रूप से दुबई, संयुक्त अरब अमीरात के लिए।';

  @override
  String get moonsightingCommittee => 'चाँद देखने की समिति';

  @override
  String get moonsightingCommitteeDesc =>
      'चाँद देखने की समिति की विधि, जो चाँद के दीदार पर आधारित है।';

  @override
  String get northAmerica => 'उत्तर अमेरिका';

  @override
  String get northAmericaDesc =>
      'इस्लामिक सोसाइटी ऑफ नॉर्थ अमेरिका (ISNA) की विधि, जो उत्तर अमेरिका में आमतौर पर उपयोग होती है।';

  @override
  String get kuwait => 'कुवैत';

  @override
  String get kuwaitDesc => 'कुवैत विधि, जो कुवैत में आमतौर पर उपयोग होती है।';

  @override
  String get qatar => 'क़तर';

  @override
  String get qatarDesc => 'क़तर विधि, जो विशेष रूप से क़तर में उपयोग होती है।';

  @override
  String get singapore => 'सिंगापुर';

  @override
  String get singaporeDesc =>
      'सिंगापुर विधि, जो विशेष रूप से सिंगापुर में उपयोग होती है।';

  @override
  String get turkey => 'तुर्की';

  @override
  String get turkeyDesc =>
      'तुर्की विधि, जो विशेष रूप से तुर्की में उपयोग होती है।';

  @override
  String get tehran => 'तेहरान';

  @override
  String get tehranDesc =>
      'तेहरान विधि, जो विशेष रूप से तेहरान में उपयोग होती है।';

  @override
  String get other => 'अन्य';

  @override
  String get otherDesc =>
      'अन्य या सामान्य गणना विधि, जिसमें कोई विशिष्ट पैरामीटर नहीं होते।';

  @override
  String get none => 'कोई नहीं';

  @override
  String get noneDesc => 'कोई विशेष अक्षांश समायोजन लागू नहीं किया गया है।';

  @override
  String get middleOfTheNight => 'आधी रात';

  @override
  String get middleOfTheNightDesc =>
      'फज्र कभी भी आधी रात से पहले नहीं होगा और ईशा कभी भी आधी रात के बाद नहीं होगा।';

  @override
  String get seventhOfTheNight => 'रात का सातवाँ हिस्सा';

  @override
  String get seventhOfTheNightDesc =>
      'फज्र कभी भी रात के अंतिम सातवें हिस्से की शुरुआत से पहले नहीं होगा और ईशा कभी भी रात के पहले सातवें हिस्से के अंत के बाद नहीं होगा।';

  @override
  String get twilightAngle => 'संध्याकाल कोण';

  @override
  String get twilightAngleDesc =>
      'रात का सातवाँ हिस्सा विधि के समान है, लेकिन 1/7 की बजाय रात का अंश फज्र कोण/60 और ईशा कोण/60 पर आधारित होता है।';

  @override
  String get hanafi => 'हन्फी';

  @override
  String get hanafiDesc => 'बाद में अस्र का समय';

  @override
  String get shafi => 'मानक';

  @override
  String get shafiDesc => 'मालिकी, शाफ़ी, हंबली - अस्र का पहले का समय';

  @override
  String get chooseLanguage => 'भाषा चुनें';

  @override
  String get chooseLanguageDesc => 'एप के लिए अपनी पसंदीदा भाषा चुनें';

  @override
  String get chooseLanguageBtn => 'चुनें';
}
