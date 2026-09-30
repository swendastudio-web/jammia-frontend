// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get languageName => 'አማርኛ';

  @override
  String get appTagline => 'ከሚያምኗቸው ሰዎች ጋር የቁጠባ ክፍሎች';

  @override
  String get chooseLanguageTitle => 'ቋንቋዎን ይምረጡ';

  @override
  String get continueButton => 'ቀጥል';

  @override
  String get language => 'ቋንቋ';

  @override
  String get email => 'ኢሜይል';

  @override
  String get password => 'የይለፍ ቃል';

  @override
  String get firstName => 'የመጀመሪያ ስም';

  @override
  String get lastName => 'የአባት ስም';

  @override
  String get logIn => 'ግባ';

  @override
  String get noAccountSignUp => 'መለያ የለዎትም? ይመዝገቡ';

  @override
  String get createAccount => 'መለያ ፍጠር';

  @override
  String get passwordHelper => 'ከ8 እስከ 72 ቁምፊዎች';

  @override
  String get emailRequired => 'ኢሜይል ያስፈልጋል';

  @override
  String get emailInvalid => 'ትክክለኛ የኢሜይል አድራሻ ያስገቡ';

  @override
  String get passwordRequired => 'የይለፍ ቃል ያስፈልጋል';

  @override
  String get passwordLength => 'የይለፍ ቃል ከ8 እስከ 72 ቁምፊዎች መሆን አለበት';

  @override
  String get firstNameRequired => 'የመጀመሪያ ስም ያስፈልጋል';

  @override
  String get lastNameRequired => 'የአባት ስም ያስፈልጋል';

  @override
  String get nameRequired => 'ስም ያስፈልጋል';

  @override
  String get amountRequired => 'መጠን ያስፈልጋል';

  @override
  String get amountAboveZero => 'ከ0 በላይ መጠን ያስገቡ';

  @override
  String get amountDecimals => 'ከአስርዮሽ ነጥብ በኋላ ቢበዛ 2 አሃዝ';

  @override
  String get currencyLetters => '3 ፊደላት';

  @override
  String get enterNumber => 'ቁጥር ያስገቡ';

  @override
  String get minTwoMembers => 'ክፍሉ ቢያንስ 2 አባላት ያስፈልጉታል';

  @override
  String planAllowsUpTo(int count) {
    return 'ዕቅድዎ እስከ $count አባላት ይፈቅዳል';
  }

  @override
  String get phoneFormat => 'ዓለም አቀፍ ቅርጸት ይጠቀሙ፣ ለምሳሌ +96891234567';

  @override
  String get currentPasswordRequired => 'የአሁኑ የይለፍ ቃል ያስፈልጋል';

  @override
  String get errorNetwork =>
      'ወደ JAMIA አገልጋይ መድረስ አልተቻለም። ግንኙነትዎን እና አገልጋዩ እየሰራ መሆኑን ያረጋግጡ።';

  @override
  String get errorTimeout => 'የJAMIA አገልጋይ ለመመለስ ረጅም ጊዜ ወሰደ። እባክዎ እንደገና ይሞክሩ።';

  @override
  String get errorSessionExpired => 'ክፍለ ጊዜዎ አብቅቷል። እባክዎ እንደገና ይግቡ።';

  @override
  String errorGeneric(int code) {
    return 'የሆነ ችግር ተፈጥሯል (ስህተት $code)።';
  }

  @override
  String get tryAgain => 'እንደገና ሞክር';

  @override
  String get myRooms => 'የእኔ ክፍሎች';

  @override
  String get profile => 'መገለጫ';

  @override
  String get newRoom => 'አዲስ ክፍል';

  @override
  String get noRoomsTitle => 'እስካሁን ምንም ክፍል የለም';

  @override
  String get noRoomsMessage => 'የቁጠባ ክፍል ይፍጠሩ፣ ወይም ከጓደኛ በተላከ የግብዣ ሊንክ ይቀላቀሉ።';

  @override
  String get joinWithInviteLink => 'በግብዣ ሊንክ ይቀላቀሉ';

  @override
  String get creator => 'ፈጣሪ';

  @override
  String roomCardSubtitle(String amount, String frequency, int max) {
    return '$amount · $frequency · እስከ $max አባላት';
  }

  @override
  String get statusOpen => 'ክፍት';

  @override
  String get statusActive => 'ንቁ';

  @override
  String get statusCompleted => 'ተጠናቋል';

  @override
  String get frequencyWeekly => 'በየሳምንቱ';

  @override
  String get frequencyBiweekly => 'በየ2 ሳምንቱ';

  @override
  String get frequencyMonthly => 'በየወሩ';

  @override
  String get paymentNotPaid => 'አልተከፈለም';

  @override
  String get paymentPaid => 'ተከፍሏል';

  @override
  String get paymentReceived => 'ደርሷል';

  @override
  String get roomName => 'የክፍሉ ስም';

  @override
  String get descriptionOptional => 'መግለጫ (አማራጭ)';

  @override
  String get amountPerPerson => 'መጠን በአንድ ሰው';

  @override
  String get currency => 'ምንዛሬ';

  @override
  String get howOften => 'በምን ያህል ጊዜ';

  @override
  String get maximumMembers => 'ከፍተኛ የአባላት ብዛት';

  @override
  String planAllowsHelper(String plan, int count) {
    return 'የ$plan ዕቅድዎ እስከ $count አባላት ይፈቅዳል';
  }

  @override
  String get createRoom => 'ክፍል ፍጠር';

  @override
  String get inviteLink => 'የግብዣ ሊንክ';

  @override
  String get showRoom => 'ክፍሉን አሳይ';

  @override
  String get pasteInviteLink => 'የደረሰዎትን የግብዣ ሊንክ ይለጥፉ።';

  @override
  String get alreadyMember => 'የዚህ ክፍል አባል ነዎት።';

  @override
  String get requestSent => 'ጥያቄው ተልኳል። የክፍሉ ፈጣሪ ይቀበለዋል ወይም አይቀበለውም።';

  @override
  String get requestToJoin => 'ለመቀላቀል ይጠይቁ';

  @override
  String get referredBy => 'የጋበዘዎት';

  @override
  String get createdBy => 'የፈጠረው';

  @override
  String get amount => 'መጠን';

  @override
  String amountPerPersonValue(String amount) {
    return '$amount በአንድ ሰው';
  }

  @override
  String get members => 'አባላት';

  @override
  String countOfMax(int count, int max) {
    return 'ከ$max $count';
  }

  @override
  String get room => 'ክፍል';

  @override
  String get perPersonEachCycle => 'በአንድ ሰው፣ በየዙሩ';

  @override
  String get totalEachCycle => 'ጠቅላላ በየዙሩ';

  @override
  String totalUpTo(String amount, int count) {
    return 'እስከ $amount ($count አባላት ሲኖሩ)';
  }

  @override
  String get firstDueDate => 'የመጀመሪያ የክፍያ ቀን';

  @override
  String get turnOrder => 'የተራ ቅደም ተከተል';

  @override
  String get turnOrderRandom => 'በዘፈቀደ';

  @override
  String get turnOrderManual => 'በፈጣሪው የተመረጠ';

  @override
  String get invitePeople => 'ሰዎችን ይጋብዙ';

  @override
  String get startRoom => 'ክፍሉን ጀምር';

  @override
  String get startRoomNeedsMembers => 'ክፍሉን ጀምር (ቢያንስ 2 አባላት ያስፈልጋሉ)';

  @override
  String get payments => 'ክፍያዎች';

  @override
  String joinRequestsTitle(int count) {
    return 'የመቀላቀል ጥያቄዎች ($count)';
  }

  @override
  String get noJoinRequests =>
      'የሚጠብቅ የለም። አንድ ሰው የግብዣ ሊንክ ሲጠቀም ጥያቄዎች እዚህ ይታያሉ።';

  @override
  String referredByName(String name) {
    return 'የጋበዘው፦ $name';
  }

  @override
  String askedAt(String date) {
    return 'የተጠየቀው $date';
  }

  @override
  String get reject => 'አትቀበል';

  @override
  String get accept => 'ተቀበል';

  @override
  String nowMember(String name) {
    return '$name አሁን አባል ነው።';
  }

  @override
  String requestRejected(String name) {
    return 'የ$name ጥያቄ ውድቅ ሆኗል።';
  }

  @override
  String membersTitle(int count, int max) {
    return 'አባላት (ከ$max $count)';
  }

  @override
  String nameYou(String name) {
    return '$name (እርስዎ)';
  }

  @override
  String get turnDecidedLater => 'ተራው ክፍሉ ሲጀመር ይወሰናል';

  @override
  String turnInfo(int turn) {
    return 'ተራ $turn · በዙር $turn ይቀበላል';
  }

  @override
  String get yourInviteLink => 'የእርስዎ የግብዣ ሊንክ';

  @override
  String get inviteLinkExplanation =>
      'የሚከፍተው ማንኛውም ሰው ለመቀላቀል መጠየቅ ይችላል። የክፍሉ ፈጣሪ እያንዳንዱን ጥያቄ ይቀበላል ወይም አይቀበልም፣ እርስዎ እንደጋበዙትም ያያል።';

  @override
  String worksUntil(String date) {
    return 'እስከ $date ይሰራል';
  }

  @override
  String get copyLink => 'ሊንኩን ቅዳ';

  @override
  String get linkCopied =>
      'ሊንኩ ተቀድቷል። በWhatsApp፣ Facebook፣ Instagram ወይም SMS ይለጥፉት።';

  @override
  String get randomOption => 'በዘፈቀደ';

  @override
  String get iChoose => 'እኔ እመርጣለሁ';

  @override
  String get randomExplanation => 'ሲጀምሩ JAMIA አባላትን በፍትሃዊነት ያደባልቃል።';

  @override
  String get manualExplanation =>
      'ቅደም ተከተሉን ለማስቀመጥ አባላትን ይጎትቱ። የመጀመሪያው መጀመሪያ ይቀበላል።';

  @override
  String get order => 'ቅደም ተከተል';

  @override
  String turnNumber(int turn) {
    return 'ተራ $turn';
  }

  @override
  String get startRoomConfirmTitle => 'ክፍሉን ልጀምር?';

  @override
  String get startRoomConfirmMessage =>
      'ከተጀመረ በኋላ ማንም መቀላቀል አይችልም፣ የተራ ቅደም ተከተሉም አይቀየርም። በመጠባበቅ ላይ ያሉ ጥያቄዎች ውድቅ ይሆናሉ።';

  @override
  String get cancel => 'ሰርዝ';

  @override
  String get start => 'ጀምር';

  @override
  String get noPaymentsTitle => 'እስካሁን ክፍያ የለም';

  @override
  String get noPaymentsMessage => 'መርሃ ግብሩ የክፍሉ ፈጣሪ ክፍሉን ሲጀምር ይታያል።';

  @override
  String get noMoneyNote =>
      'JAMIA ገንዘብ አያስተላልፍም። አባላት ከመተግበሪያው ውጭ ይከፋፈላሉ፣ እዚህ ይመዘግባሉ።';

  @override
  String cycleHeader(int cycle, String date) {
    return 'ዙር $cycle · $date';
  }

  @override
  String receivedCount(int done, int total) {
    return '$done/$total ደርሷል';
  }

  @override
  String youReceiveTotal(String amount) {
    return 'በአጠቃላይ $amount ይቀበላሉ (የራስዎ ድርሻ ጨምሮ)';
  }

  @override
  String personReceivesTotal(String name, String amount) {
    return '$name በአጠቃላይ $amount ይቀበላል (የራሱ ድርሻ ጨምሮ)';
  }

  @override
  String get youPay => 'እርስዎ ይከፍላሉ';

  @override
  String personPays(String name) {
    return '$name ይከፍላል';
  }

  @override
  String get iPaid => 'ከፍያለሁ';

  @override
  String get iReceivedIt => 'ደርሶኛል';

  @override
  String get confirmReceivedTitle => 'መድረሱን ያረጋግጣሉ?';

  @override
  String confirmReceivedMessage(String amount, String name) {
    return '$amount ከ$name።';
  }

  @override
  String get yesReceived => 'አዎ፣ ደርሷል';

  @override
  String get plan => 'ዕቅድ';

  @override
  String get role => 'ሚና';

  @override
  String get adminRole => 'የJAMIA አስተዳዳሪ';

  @override
  String get phoneOptional => 'ስልክ (አማራጭ)';

  @override
  String get save => 'አስቀምጥ';

  @override
  String get profileSaved => 'መገለጫው ተቀምጧል።';

  @override
  String get changePassword => 'የይለፍ ቃል ቀይር';

  @override
  String get logOut => 'ውጣ';

  @override
  String get currentPassword => 'የአሁኑ የይለፍ ቃል';

  @override
  String get newPassword => 'አዲስ የይለፍ ቃል';

  @override
  String get passwordChanged => 'የይለፍ ቃል ተቀይሯል። ከሌሎች መሣሪያዎችዎ ወጥተዋል።';

  @override
  String get frequencyFiveMinutes => 'በየ5 ደቂቃው (ሙከራ)';

  @override
  String roundTitle(int number) {
    return 'ዙር $number';
  }

  @override
  String turnOfCount(int turn, int count) {
    return 'ተራ $turn ከ$count';
  }

  @override
  String receivesNow(String name) {
    return 'አሁን $name ይቀበላል';
  }

  @override
  String get youReceiveNow => 'አሁን እርስዎ ይቀበላሉ';

  @override
  String nextTurnAt(String time) {
    return 'ቀጣዩ ተራ በ$time';
  }

  @override
  String roundStartsAt(String time) {
    return 'ዙሩ በ$time ይጀምራል';
  }

  @override
  String get roundEndingNow => 'የመጨረሻው ተራ አብቅቷል። ክፍሉ በቅርቡ እንደገና ይከፈታል።';

  @override
  String roundsFinished(int count) {
    return 'የተጠናቀቁ ዙሮች፦ $count';
  }

  @override
  String startRoundNumber(int number) {
    return 'ዙር $number ጀምር';
  }

  @override
  String get roundsHistory => 'የዙሮች ታሪክ';

  @override
  String get noRoundsYet => 'እስካሁን ዙር የለም። ታሪኩ የመጀመሪያው ዙር ሲጀመር ይታያል።';

  @override
  String get roundStatusActive => 'በሂደት ላይ';

  @override
  String get roundStatusCompleted => 'ተጠናቋል';

  @override
  String roundDates(String start, String end) {
    return '$start – $end';
  }

  @override
  String get changeMemberCount => 'የአባላትን ቁጥር ቀይር';

  @override
  String get maxMembersSaved => 'የአባላት ቁጥር ተዘምኗል።';

  @override
  String get removeMember => 'ከክፍሉ አስወግድ';

  @override
  String removeMemberConfirm(String name) {
    return '$nameን ከክፍሉ ላስወግድ? የክፍያ ታሪኩ ይቀመጣል።';
  }

  @override
  String get remove => 'አስወግድ';

  @override
  String memberRemoved(String name) {
    return '$name ተወግዷል።';
  }

  @override
  String get leaveRoom => 'ክፍሉን ልቀቅ';

  @override
  String get leaveRoomConfirm => 'ይህን ክፍል ይለቃሉ? በኋላ እንደገና ሊጋበዙ ይችላሉ።';

  @override
  String get leave => 'ልቀቅ';

  @override
  String get late => 'ዘግይቷል';

  @override
  String get nowLabel => 'አሁን';

  @override
  String get fiveMinuteStartsNow =>
      'የሙከራ ክፍል፦ ዙሩ አሁን ይጀምራል፣ ተራው በየ5 ደቂቃው ይቀየራል።';

  @override
  String get betweenRoundsNote =>
      'በዙሮች መካከል ሰዎችን መጋበዝ፣ የአባላትን ቁጥር መቀየርና አባላትን ማስወገድ ይችላሉ። አባላትም መውጣት ይችላሉ።';
}
