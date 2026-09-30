// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageName => 'English';

  @override
  String get appTagline => 'Savings rooms with people you trust';

  @override
  String get chooseLanguageTitle => 'Choose your language';

  @override
  String get continueButton => 'Continue';

  @override
  String get language => 'Language';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get logIn => 'Log in';

  @override
  String get noAccountSignUp => 'Don\'t have an account? Sign up';

  @override
  String get createAccount => 'Create account';

  @override
  String get passwordHelper => '8 to 72 characters';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordLength => 'Password must be 8 to 72 characters';

  @override
  String get firstNameRequired => 'First name is required';

  @override
  String get lastNameRequired => 'Last name is required';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get amountRequired => 'Amount is required';

  @override
  String get amountAboveZero => 'Enter an amount above 0';

  @override
  String get amountDecimals => 'At most 2 decimal places';

  @override
  String get currencyLetters => '3 letters';

  @override
  String get enterNumber => 'Enter a number';

  @override
  String get minTwoMembers => 'A room needs at least 2 members';

  @override
  String planAllowsUpTo(int count) {
    return 'Your plan allows up to $count members';
  }

  @override
  String get phoneFormat => 'Use international format, e.g. +96891234567';

  @override
  String get currentPasswordRequired => 'Current password is required';

  @override
  String get errorNetwork =>
      'Cannot reach the JAMIA server. Check your connection and that the backend is running.';

  @override
  String get errorTimeout =>
      'The JAMIA server took too long to answer. Please try again.';

  @override
  String get errorSessionExpired =>
      'Your session has expired. Please log in again.';

  @override
  String errorGeneric(int code) {
    return 'Something went wrong (error $code).';
  }

  @override
  String get tryAgain => 'Try again';

  @override
  String get myRooms => 'My rooms';

  @override
  String get profile => 'Profile';

  @override
  String get newRoom => 'New room';

  @override
  String get noRoomsTitle => 'No rooms yet';

  @override
  String get noRoomsMessage =>
      'Create a savings room, or join one with an invite link from a friend.';

  @override
  String get joinWithInviteLink => 'Join with invite link';

  @override
  String get creator => 'Creator';

  @override
  String roomCardSubtitle(String amount, String frequency, int max) {
    return '$amount · $frequency · up to $max members';
  }

  @override
  String get statusOpen => 'Open';

  @override
  String get statusActive => 'Active';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get frequencyWeekly => 'Weekly';

  @override
  String get frequencyBiweekly => 'Every 2 weeks';

  @override
  String get frequencyMonthly => 'Monthly';

  @override
  String get paymentNotPaid => 'Not paid';

  @override
  String get paymentPaid => 'Paid';

  @override
  String get paymentReceived => 'Received';

  @override
  String get roomName => 'Room name';

  @override
  String get descriptionOptional => 'Description (optional)';

  @override
  String get amountPerPerson => 'Amount per person';

  @override
  String get currency => 'Currency';

  @override
  String get howOften => 'How often';

  @override
  String get maximumMembers => 'Maximum members';

  @override
  String planAllowsHelper(String plan, int count) {
    return 'Your $plan plan allows up to $count members';
  }

  @override
  String get createRoom => 'Create room';

  @override
  String get inviteLink => 'Invite link';

  @override
  String get showRoom => 'Show room';

  @override
  String get pasteInviteLink => 'Paste the invite link you received.';

  @override
  String get alreadyMember => 'You are already a member of this room.';

  @override
  String get requestSent =>
      'Request sent. The room creator will accept or reject it.';

  @override
  String get requestToJoin => 'Request to join';

  @override
  String get referredBy => 'Referred by';

  @override
  String get createdBy => 'Created by';

  @override
  String get amount => 'Amount';

  @override
  String amountPerPersonValue(String amount) {
    return '$amount per person';
  }

  @override
  String get members => 'Members';

  @override
  String countOfMax(int count, int max) {
    return '$count of $max';
  }

  @override
  String get room => 'Room';

  @override
  String get perPersonEachCycle => 'per person, each cycle';

  @override
  String get totalEachCycle => 'Total each cycle';

  @override
  String totalUpTo(String amount, int count) {
    return 'Up to $amount (with $count members)';
  }

  @override
  String get firstDueDate => 'First due date';

  @override
  String get turnOrder => 'Turn order';

  @override
  String get turnOrderRandom => 'Random';

  @override
  String get turnOrderManual => 'Chosen by creator';

  @override
  String get invitePeople => 'Invite people';

  @override
  String get startRoom => 'Start room';

  @override
  String get startRoomNeedsMembers => 'Start room (needs at least 2 members)';

  @override
  String get payments => 'Payments';

  @override
  String joinRequestsTitle(int count) {
    return 'Join requests ($count)';
  }

  @override
  String get noJoinRequests =>
      'No one is waiting. Requests appear here when someone uses an invite link.';

  @override
  String referredByName(String name) {
    return 'Referred by $name';
  }

  @override
  String askedAt(String date) {
    return 'Asked $date';
  }

  @override
  String get reject => 'Reject';

  @override
  String get accept => 'Accept';

  @override
  String nowMember(String name) {
    return '$name is now a member.';
  }

  @override
  String requestRejected(String name) {
    return 'Request from $name rejected.';
  }

  @override
  String membersTitle(int count, int max) {
    return 'Members ($count of $max)';
  }

  @override
  String nameYou(String name) {
    return '$name (you)';
  }

  @override
  String get turnDecidedLater => 'Turn decided when the room starts';

  @override
  String turnInfo(int turn) {
    return 'Turn $turn · receives in cycle $turn';
  }

  @override
  String get yourInviteLink => 'Your invite link';

  @override
  String get inviteLinkExplanation =>
      'Anyone who opens it can ask to join. The room creator accepts or rejects each request and sees that you referred them.';

  @override
  String worksUntil(String date) {
    return 'Works until $date';
  }

  @override
  String get copyLink => 'Copy link';

  @override
  String get linkCopied =>
      'Link copied. Paste it in WhatsApp, Facebook, Instagram or SMS.';

  @override
  String get randomOption => 'Random';

  @override
  String get iChoose => 'I choose';

  @override
  String get randomExplanation =>
      'JAMIA shuffles the members fairly when you start.';

  @override
  String get manualExplanation =>
      'Drag members to set the order. The first one receives first.';

  @override
  String get order => 'Order';

  @override
  String turnNumber(int turn) {
    return 'Turn $turn';
  }

  @override
  String get startRoomConfirmTitle => 'Start the room?';

  @override
  String get startRoomConfirmMessage =>
      'After starting, nobody can join and the turn order cannot be changed. Requests still waiting will be rejected.';

  @override
  String get cancel => 'Cancel';

  @override
  String get start => 'Start';

  @override
  String get noPaymentsTitle => 'No payments yet';

  @override
  String get noPaymentsMessage =>
      'The schedule appears when the room creator starts the room.';

  @override
  String get noMoneyNote =>
      'JAMIA does not move money. Members pay each other outside the app and record it here.';

  @override
  String cycleHeader(int cycle, String date) {
    return 'Cycle $cycle · $date';
  }

  @override
  String receivedCount(int done, int total) {
    return '$done/$total received';
  }

  @override
  String youReceiveTotal(String amount) {
    return 'You receive $amount in total (own share included)';
  }

  @override
  String personReceivesTotal(String name, String amount) {
    return '$name receives $amount in total (own share included)';
  }

  @override
  String get youPay => 'You pay';

  @override
  String personPays(String name) {
    return '$name pays';
  }

  @override
  String get iPaid => 'I paid';

  @override
  String get iReceivedIt => 'I received it';

  @override
  String get confirmReceivedTitle => 'Confirm you received it?';

  @override
  String confirmReceivedMessage(String amount, String name) {
    return '$amount from $name.';
  }

  @override
  String get yesReceived => 'Yes, received';

  @override
  String get plan => 'Plan';

  @override
  String get role => 'Role';

  @override
  String get adminRole => 'JAMIA admin';

  @override
  String get phoneOptional => 'Phone (optional)';

  @override
  String get save => 'Save';

  @override
  String get profileSaved => 'Profile saved.';

  @override
  String get changePassword => 'Change password';

  @override
  String get logOut => 'Log out';

  @override
  String get currentPassword => 'Current password';

  @override
  String get newPassword => 'New password';

  @override
  String get passwordChanged =>
      'Password changed. Your other devices were signed out.';

  @override
  String get frequencyFiveMinutes => 'Every 5 minutes (test)';

  @override
  String roundTitle(int number) {
    return 'Round $number';
  }

  @override
  String turnOfCount(int turn, int count) {
    return 'Turn $turn of $count';
  }

  @override
  String receivesNow(String name) {
    return '$name receives now';
  }

  @override
  String get youReceiveNow => 'You receive now';

  @override
  String nextTurnAt(String time) {
    return 'Next turn at $time';
  }

  @override
  String roundStartsAt(String time) {
    return 'The round starts at $time';
  }

  @override
  String get roundEndingNow =>
      'The last turn has ended. The room opens again in a moment.';

  @override
  String roundsFinished(int count) {
    return 'Finished rounds: $count';
  }

  @override
  String startRoundNumber(int number) {
    return 'Start round $number';
  }

  @override
  String get roundsHistory => 'Rounds history';

  @override
  String get noRoundsYet =>
      'No rounds yet. The history appears after the first round starts.';

  @override
  String get roundStatusActive => 'Running';

  @override
  String get roundStatusCompleted => 'Finished';

  @override
  String roundDates(String start, String end) {
    return '$start – $end';
  }

  @override
  String get changeMemberCount => 'Change number of members';

  @override
  String get maxMembersSaved => 'Number of members updated.';

  @override
  String get removeMember => 'Remove from room';

  @override
  String removeMemberConfirm(String name) {
    return 'Remove $name from the room? Their payment history is kept.';
  }

  @override
  String get remove => 'Remove';

  @override
  String memberRemoved(String name) {
    return '$name was removed.';
  }

  @override
  String get leaveRoom => 'Leave room';

  @override
  String get leaveRoomConfirm =>
      'Leave this room? You can be invited again later.';

  @override
  String get leave => 'Leave';

  @override
  String get late => 'Late';

  @override
  String get nowLabel => 'Now';

  @override
  String get fiveMinuteStartsNow =>
      'Test room: the round starts now and the turn moves every 5 minutes.';

  @override
  String get betweenRoundsNote =>
      'Between rounds you can invite people, change the number of members and remove members. Members can leave.';
}
