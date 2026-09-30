// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get languageName => 'العربية';

  @override
  String get appTagline => 'غرف ادخار مع أشخاص تثق بهم';

  @override
  String get chooseLanguageTitle => 'اختر لغتك';

  @override
  String get continueButton => 'متابعة';

  @override
  String get language => 'اللغة';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get noAccountSignUp => 'ليس لديك حساب؟ أنشئ حساباً';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get passwordHelper => 'من 8 إلى 72 حرفاً';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get emailInvalid => 'أدخل بريداً إلكترونياً صحيحاً';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordLength => 'يجب أن تكون كلمة المرور من 8 إلى 72 حرفاً';

  @override
  String get firstNameRequired => 'الاسم الأول مطلوب';

  @override
  String get lastNameRequired => 'اسم العائلة مطلوب';

  @override
  String get nameRequired => 'الاسم مطلوب';

  @override
  String get amountRequired => 'المبلغ مطلوب';

  @override
  String get amountAboveZero => 'أدخل مبلغاً أكبر من 0';

  @override
  String get amountDecimals => 'خانتان عشريتان كحد أقصى';

  @override
  String get currencyLetters => '3 أحرف';

  @override
  String get enterNumber => 'أدخل رقماً';

  @override
  String get minTwoMembers => 'تحتاج الغرفة إلى عضوين على الأقل';

  @override
  String planAllowsUpTo(int count) {
    return 'باقتك تسمح بحد أقصى $count أعضاء';
  }

  @override
  String get phoneFormat => 'استخدم الصيغة الدولية، مثل ‎+96891234567';

  @override
  String get currentPasswordRequired => 'كلمة المرور الحالية مطلوبة';

  @override
  String get errorNetwork =>
      'تعذر الوصول إلى خادم JAMIA. تحقق من اتصالك ومن تشغيل الخادم.';

  @override
  String get errorTimeout =>
      'استغرق خادم JAMIA وقتاً طويلاً للرد. حاول مرة أخرى.';

  @override
  String get errorSessionExpired => 'انتهت جلستك. يرجى تسجيل الدخول مرة أخرى.';

  @override
  String errorGeneric(int code) {
    return 'حدث خطأ ما (خطأ $code).';
  }

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get myRooms => 'غرفي';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get newRoom => 'غرفة جديدة';

  @override
  String get noRoomsTitle => 'لا توجد غرف بعد';

  @override
  String get noRoomsMessage =>
      'أنشئ غرفة ادخار، أو انضم إلى غرفة برابط دعوة من صديق.';

  @override
  String get joinWithInviteLink => 'الانضمام برابط دعوة';

  @override
  String get creator => 'المنشئ';

  @override
  String roomCardSubtitle(String amount, String frequency, int max) {
    return '$amount · $frequency · حتى $max أعضاء';
  }

  @override
  String get statusOpen => 'مفتوحة';

  @override
  String get statusActive => 'نشطة';

  @override
  String get statusCompleted => 'مكتملة';

  @override
  String get frequencyWeekly => 'أسبوعياً';

  @override
  String get frequencyBiweekly => 'كل أسبوعين';

  @override
  String get frequencyMonthly => 'شهرياً';

  @override
  String get paymentNotPaid => 'لم يُدفع';

  @override
  String get paymentPaid => 'مدفوع';

  @override
  String get paymentReceived => 'مستلم';

  @override
  String get roomName => 'اسم الغرفة';

  @override
  String get descriptionOptional => 'الوصف (اختياري)';

  @override
  String get amountPerPerson => 'المبلغ لكل شخص';

  @override
  String get currency => 'العملة';

  @override
  String get howOften => 'كم مرة';

  @override
  String get maximumMembers => 'الحد الأقصى للأعضاء';

  @override
  String planAllowsHelper(String plan, int count) {
    return 'باقة $plan تسمح بحد أقصى $count أعضاء';
  }

  @override
  String get createRoom => 'إنشاء الغرفة';

  @override
  String get inviteLink => 'رابط الدعوة';

  @override
  String get showRoom => 'عرض الغرفة';

  @override
  String get pasteInviteLink => 'الصق رابط الدعوة الذي وصلك.';

  @override
  String get alreadyMember => 'أنت عضو في هذه الغرفة بالفعل.';

  @override
  String get requestSent => 'تم إرسال الطلب. سيقبله منشئ الغرفة أو يرفضه.';

  @override
  String get requestToJoin => 'طلب الانضمام';

  @override
  String get referredBy => 'بدعوة من';

  @override
  String get createdBy => 'أنشأها';

  @override
  String get amount => 'المبلغ';

  @override
  String amountPerPersonValue(String amount) {
    return '$amount لكل شخص';
  }

  @override
  String get members => 'الأعضاء';

  @override
  String countOfMax(int count, int max) {
    return '$count من $max';
  }

  @override
  String get room => 'الغرفة';

  @override
  String get perPersonEachCycle => 'لكل شخص، في كل دورة';

  @override
  String get totalEachCycle => 'المجموع في كل دورة';

  @override
  String totalUpTo(String amount, int count) {
    return 'حتى $amount (مع $count أعضاء)';
  }

  @override
  String get firstDueDate => 'أول موعد استحقاق';

  @override
  String get turnOrder => 'ترتيب الأدوار';

  @override
  String get turnOrderRandom => 'عشوائي';

  @override
  String get turnOrderManual => 'يحدده المنشئ';

  @override
  String get invitePeople => 'دعوة أشخاص';

  @override
  String get startRoom => 'بدء الغرفة';

  @override
  String get startRoomNeedsMembers => 'بدء الغرفة (تحتاج عضوين على الأقل)';

  @override
  String get payments => 'المدفوعات';

  @override
  String joinRequestsTitle(int count) {
    return 'طلبات الانضمام ($count)';
  }

  @override
  String get noJoinRequests =>
      'لا أحد في الانتظار. تظهر الطلبات هنا عندما يستخدم أحدهم رابط دعوة.';

  @override
  String referredByName(String name) {
    return 'بدعوة من $name';
  }

  @override
  String askedAt(String date) {
    return 'طُلب في $date';
  }

  @override
  String get reject => 'رفض';

  @override
  String get accept => 'قبول';

  @override
  String nowMember(String name) {
    return 'أصبح $name عضواً الآن.';
  }

  @override
  String requestRejected(String name) {
    return 'تم رفض طلب $name.';
  }

  @override
  String membersTitle(int count, int max) {
    return 'الأعضاء ($count من $max)';
  }

  @override
  String nameYou(String name) {
    return '$name (أنت)';
  }

  @override
  String get turnDecidedLater => 'يُحدد الدور عند بدء الغرفة';

  @override
  String turnInfo(int turn) {
    return 'الدور $turn · يستلم في الدورة $turn';
  }

  @override
  String get yourInviteLink => 'رابط دعوتك';

  @override
  String get inviteLinkExplanation =>
      'يمكن لأي شخص يفتحه أن يطلب الانضمام. يقبل منشئ الغرفة كل طلب أو يرفضه ويرى أنك من دعوته.';

  @override
  String worksUntil(String date) {
    return 'صالح حتى $date';
  }

  @override
  String get copyLink => 'نسخ الرابط';

  @override
  String get linkCopied =>
      'تم نسخ الرابط. الصقه في واتساب أو فيسبوك أو إنستغرام أو رسالة نصية.';

  @override
  String get randomOption => 'عشوائي';

  @override
  String get iChoose => 'أنا أختار';

  @override
  String get randomExplanation =>
      'يرتّب JAMIA الأعضاء عشوائياً وبعدل عند البدء.';

  @override
  String get manualExplanation =>
      'اسحب الأعضاء لتحديد الترتيب. الأول يستلم أولاً.';

  @override
  String get order => 'الترتيب';

  @override
  String turnNumber(int turn) {
    return 'الدور $turn';
  }

  @override
  String get startRoomConfirmTitle => 'بدء الغرفة؟';

  @override
  String get startRoomConfirmMessage =>
      'بعد البدء، لا يمكن لأحد الانضمام ولا يمكن تغيير ترتيب الأدوار. سيتم رفض الطلبات المنتظرة.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get start => 'بدء';

  @override
  String get noPaymentsTitle => 'لا توجد مدفوعات بعد';

  @override
  String get noPaymentsMessage => 'يظهر الجدول عندما يبدأ منشئ الغرفة الغرفة.';

  @override
  String get noMoneyNote =>
      'لا ينقل JAMIA الأموال. يدفع الأعضاء لبعضهم خارج التطبيق ويسجلون ذلك هنا.';

  @override
  String cycleHeader(int cycle, String date) {
    return 'الدورة $cycle · $date';
  }

  @override
  String receivedCount(int done, int total) {
    return '$done/$total مستلم';
  }

  @override
  String youReceiveTotal(String amount) {
    return 'تستلم $amount إجمالاً (بما فيه حصتك)';
  }

  @override
  String personReceivesTotal(String name, String amount) {
    return 'يستلم $name $amount إجمالاً (بما فيه حصته)';
  }

  @override
  String get youPay => 'أنت تدفع';

  @override
  String personPays(String name) {
    return '$name يدفع';
  }

  @override
  String get iPaid => 'دفعت';

  @override
  String get iReceivedIt => 'استلمته';

  @override
  String get confirmReceivedTitle => 'تأكيد الاستلام؟';

  @override
  String confirmReceivedMessage(String amount, String name) {
    return '$amount من $name.';
  }

  @override
  String get yesReceived => 'نعم، استلمته';

  @override
  String get plan => 'الباقة';

  @override
  String get role => 'الدور';

  @override
  String get adminRole => 'مسؤول JAMIA';

  @override
  String get phoneOptional => 'الهاتف (اختياري)';

  @override
  String get save => 'حفظ';

  @override
  String get profileSaved => 'تم حفظ الملف الشخصي.';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get passwordChanged =>
      'تم تغيير كلمة المرور. تم تسجيل الخروج من أجهزتك الأخرى.';
}
