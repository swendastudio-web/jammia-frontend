import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
    Locale('ru'),
  ];

  /// No description provided for @languageName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Savings rooms with people you trust'**
  String get appTagline;

  /// No description provided for @chooseLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguageTitle;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @noAccountSignUp.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get noAccountSignUp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @passwordHelper.
  ///
  /// In en, this message translates to:
  /// **'8 to 72 characters'**
  String get passwordHelper;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be 8 to 72 characters'**
  String get passwordLength;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// No description provided for @lastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameRequired;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Amount is required'**
  String get amountRequired;

  /// No description provided for @amountAboveZero.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount above 0'**
  String get amountAboveZero;

  /// No description provided for @amountDecimals.
  ///
  /// In en, this message translates to:
  /// **'At most 2 decimal places'**
  String get amountDecimals;

  /// No description provided for @currencyLetters.
  ///
  /// In en, this message translates to:
  /// **'3 letters'**
  String get currencyLetters;

  /// No description provided for @enterNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a number'**
  String get enterNumber;

  /// No description provided for @minTwoMembers.
  ///
  /// In en, this message translates to:
  /// **'A room needs at least 2 members'**
  String get minTwoMembers;

  /// No description provided for @planAllowsUpTo.
  ///
  /// In en, this message translates to:
  /// **'Your plan allows up to {count} members'**
  String planAllowsUpTo(int count);

  /// No description provided for @phoneFormat.
  ///
  /// In en, this message translates to:
  /// **'Use international format, e.g. +96891234567'**
  String get phoneFormat;

  /// No description provided for @currentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Current password is required'**
  String get currentPasswordRequired;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Cannot reach the JAMIA server. Check your connection and that the backend is running.'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The JAMIA server took too long to answer. Please try again.'**
  String get errorTimeout;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get errorSessionExpired;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong (error {code}).'**
  String errorGeneric(int code);

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @myRooms.
  ///
  /// In en, this message translates to:
  /// **'My rooms'**
  String get myRooms;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @newRoom.
  ///
  /// In en, this message translates to:
  /// **'New room'**
  String get newRoom;

  /// No description provided for @noRoomsTitle.
  ///
  /// In en, this message translates to:
  /// **'No rooms yet'**
  String get noRoomsTitle;

  /// No description provided for @noRoomsMessage.
  ///
  /// In en, this message translates to:
  /// **'Create a savings room, or join one with an invite link from a friend.'**
  String get noRoomsMessage;

  /// No description provided for @joinWithInviteLink.
  ///
  /// In en, this message translates to:
  /// **'Join with invite link'**
  String get joinWithInviteLink;

  /// No description provided for @creator.
  ///
  /// In en, this message translates to:
  /// **'Creator'**
  String get creator;

  /// No description provided for @roomCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{amount} · {frequency} · up to {max} members'**
  String roomCardSubtitle(String amount, String frequency, int max);

  /// No description provided for @statusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get statusOpen;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @frequencyWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get frequencyWeekly;

  /// No description provided for @frequencyBiweekly.
  ///
  /// In en, this message translates to:
  /// **'Every 2 weeks'**
  String get frequencyBiweekly;

  /// No description provided for @frequencyMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get frequencyMonthly;

  /// No description provided for @paymentNotPaid.
  ///
  /// In en, this message translates to:
  /// **'Not paid'**
  String get paymentNotPaid;

  /// No description provided for @paymentPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paymentPaid;

  /// No description provided for @paymentReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get paymentReceived;

  /// No description provided for @roomName.
  ///
  /// In en, this message translates to:
  /// **'Room name'**
  String get roomName;

  /// No description provided for @descriptionOptional.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get descriptionOptional;

  /// No description provided for @amountPerPerson.
  ///
  /// In en, this message translates to:
  /// **'Amount per person'**
  String get amountPerPerson;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @howOften.
  ///
  /// In en, this message translates to:
  /// **'How often'**
  String get howOften;

  /// No description provided for @maximumMembers.
  ///
  /// In en, this message translates to:
  /// **'Maximum members'**
  String get maximumMembers;

  /// No description provided for @planAllowsHelper.
  ///
  /// In en, this message translates to:
  /// **'Your {plan} plan allows up to {count} members'**
  String planAllowsHelper(String plan, int count);

  /// No description provided for @createRoom.
  ///
  /// In en, this message translates to:
  /// **'Create room'**
  String get createRoom;

  /// No description provided for @inviteLink.
  ///
  /// In en, this message translates to:
  /// **'Invite link'**
  String get inviteLink;

  /// No description provided for @showRoom.
  ///
  /// In en, this message translates to:
  /// **'Show room'**
  String get showRoom;

  /// No description provided for @pasteInviteLink.
  ///
  /// In en, this message translates to:
  /// **'Paste the invite link you received.'**
  String get pasteInviteLink;

  /// No description provided for @alreadyMember.
  ///
  /// In en, this message translates to:
  /// **'You are already a member of this room.'**
  String get alreadyMember;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent. The room creator will accept or reject it.'**
  String get requestSent;

  /// No description provided for @requestToJoin.
  ///
  /// In en, this message translates to:
  /// **'Request to join'**
  String get requestToJoin;

  /// No description provided for @referredBy.
  ///
  /// In en, this message translates to:
  /// **'Referred by'**
  String get referredBy;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created by'**
  String get createdBy;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @amountPerPersonValue.
  ///
  /// In en, this message translates to:
  /// **'{amount} per person'**
  String amountPerPersonValue(String amount);

  /// No description provided for @members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get members;

  /// No description provided for @countOfMax.
  ///
  /// In en, this message translates to:
  /// **'{count} of {max}'**
  String countOfMax(int count, int max);

  /// No description provided for @room.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get room;

  /// No description provided for @perPersonEachCycle.
  ///
  /// In en, this message translates to:
  /// **'per person, each cycle'**
  String get perPersonEachCycle;

  /// No description provided for @totalEachCycle.
  ///
  /// In en, this message translates to:
  /// **'Total each cycle'**
  String get totalEachCycle;

  /// No description provided for @totalUpTo.
  ///
  /// In en, this message translates to:
  /// **'Up to {amount} (with {count} members)'**
  String totalUpTo(String amount, int count);

  /// No description provided for @firstDueDate.
  ///
  /// In en, this message translates to:
  /// **'First due date'**
  String get firstDueDate;

  /// No description provided for @turnOrder.
  ///
  /// In en, this message translates to:
  /// **'Turn order'**
  String get turnOrder;

  /// No description provided for @turnOrderRandom.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get turnOrderRandom;

  /// No description provided for @turnOrderManual.
  ///
  /// In en, this message translates to:
  /// **'Chosen by creator'**
  String get turnOrderManual;

  /// No description provided for @invitePeople.
  ///
  /// In en, this message translates to:
  /// **'Invite people'**
  String get invitePeople;

  /// No description provided for @startRoom.
  ///
  /// In en, this message translates to:
  /// **'Start room'**
  String get startRoom;

  /// No description provided for @startRoomNeedsMembers.
  ///
  /// In en, this message translates to:
  /// **'Start room (needs at least 2 members)'**
  String get startRoomNeedsMembers;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @joinRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Join requests ({count})'**
  String joinRequestsTitle(int count);

  /// No description provided for @noJoinRequests.
  ///
  /// In en, this message translates to:
  /// **'No one is waiting. Requests appear here when someone uses an invite link.'**
  String get noJoinRequests;

  /// No description provided for @referredByName.
  ///
  /// In en, this message translates to:
  /// **'Referred by {name}'**
  String referredByName(String name);

  /// No description provided for @askedAt.
  ///
  /// In en, this message translates to:
  /// **'Asked {date}'**
  String askedAt(String date);

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @nowMember.
  ///
  /// In en, this message translates to:
  /// **'{name} is now a member.'**
  String nowMember(String name);

  /// No description provided for @requestRejected.
  ///
  /// In en, this message translates to:
  /// **'Request from {name} rejected.'**
  String requestRejected(String name);

  /// No description provided for @membersTitle.
  ///
  /// In en, this message translates to:
  /// **'Members ({count} of {max})'**
  String membersTitle(int count, int max);

  /// No description provided for @nameYou.
  ///
  /// In en, this message translates to:
  /// **'{name} (you)'**
  String nameYou(String name);

  /// No description provided for @turnDecidedLater.
  ///
  /// In en, this message translates to:
  /// **'Turn decided when the room starts'**
  String get turnDecidedLater;

  /// No description provided for @turnInfo.
  ///
  /// In en, this message translates to:
  /// **'Turn {turn} · receives in cycle {turn}'**
  String turnInfo(int turn);

  /// No description provided for @yourInviteLink.
  ///
  /// In en, this message translates to:
  /// **'Your invite link'**
  String get yourInviteLink;

  /// No description provided for @inviteLinkExplanation.
  ///
  /// In en, this message translates to:
  /// **'Anyone who opens it can ask to join. The room creator accepts or rejects each request and sees that you referred them.'**
  String get inviteLinkExplanation;

  /// No description provided for @worksUntil.
  ///
  /// In en, this message translates to:
  /// **'Works until {date}'**
  String worksUntil(String date);

  /// No description provided for @copyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get copyLink;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied. Paste it in WhatsApp, Facebook, Instagram or SMS.'**
  String get linkCopied;

  /// No description provided for @randomOption.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get randomOption;

  /// No description provided for @iChoose.
  ///
  /// In en, this message translates to:
  /// **'I choose'**
  String get iChoose;

  /// No description provided for @randomExplanation.
  ///
  /// In en, this message translates to:
  /// **'JAMIA shuffles the members fairly when you start.'**
  String get randomExplanation;

  /// No description provided for @manualExplanation.
  ///
  /// In en, this message translates to:
  /// **'Drag members to set the order. The first one receives first.'**
  String get manualExplanation;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @turnNumber.
  ///
  /// In en, this message translates to:
  /// **'Turn {turn}'**
  String turnNumber(int turn);

  /// No description provided for @startRoomConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Start the room?'**
  String get startRoomConfirmTitle;

  /// No description provided for @startRoomConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'After starting, nobody can join and the turn order cannot be changed. Requests still waiting will be rejected.'**
  String get startRoomConfirmMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @noPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'No payments yet'**
  String get noPaymentsTitle;

  /// No description provided for @noPaymentsMessage.
  ///
  /// In en, this message translates to:
  /// **'The schedule appears when the room creator starts the room.'**
  String get noPaymentsMessage;

  /// No description provided for @noMoneyNote.
  ///
  /// In en, this message translates to:
  /// **'JAMIA does not move money. Members pay each other outside the app and record it here.'**
  String get noMoneyNote;

  /// No description provided for @cycleHeader.
  ///
  /// In en, this message translates to:
  /// **'Cycle {cycle} · {date}'**
  String cycleHeader(int cycle, String date);

  /// No description provided for @receivedCount.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} received'**
  String receivedCount(int done, int total);

  /// No description provided for @youReceiveTotal.
  ///
  /// In en, this message translates to:
  /// **'You receive {amount} in total (own share included)'**
  String youReceiveTotal(String amount);

  /// No description provided for @personReceivesTotal.
  ///
  /// In en, this message translates to:
  /// **'{name} receives {amount} in total (own share included)'**
  String personReceivesTotal(String name, String amount);

  /// No description provided for @youPay.
  ///
  /// In en, this message translates to:
  /// **'You pay'**
  String get youPay;

  /// No description provided for @personPays.
  ///
  /// In en, this message translates to:
  /// **'{name} pays'**
  String personPays(String name);

  /// No description provided for @iPaid.
  ///
  /// In en, this message translates to:
  /// **'I paid'**
  String get iPaid;

  /// No description provided for @iReceivedIt.
  ///
  /// In en, this message translates to:
  /// **'I received it'**
  String get iReceivedIt;

  /// No description provided for @confirmReceivedTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm you received it?'**
  String get confirmReceivedTitle;

  /// No description provided for @confirmReceivedMessage.
  ///
  /// In en, this message translates to:
  /// **'{amount} from {name}.'**
  String confirmReceivedMessage(String amount, String name);

  /// No description provided for @yesReceived.
  ///
  /// In en, this message translates to:
  /// **'Yes, received'**
  String get yesReceived;

  /// No description provided for @plan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get plan;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @adminRole.
  ///
  /// In en, this message translates to:
  /// **'JAMIA admin'**
  String get adminRole;

  /// No description provided for @phoneOptional.
  ///
  /// In en, this message translates to:
  /// **'Phone (optional)'**
  String get phoneOptional;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile saved.'**
  String get profileSaved;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed. Your other devices were signed out.'**
  String get passwordChanged;

  /// No description provided for @frequencyFiveMinutes.
  ///
  /// In en, this message translates to:
  /// **'Every 5 minutes (test)'**
  String get frequencyFiveMinutes;

  /// No description provided for @roundTitle.
  ///
  /// In en, this message translates to:
  /// **'Round {number}'**
  String roundTitle(int number);

  /// No description provided for @turnOfCount.
  ///
  /// In en, this message translates to:
  /// **'Turn {turn} of {count}'**
  String turnOfCount(int turn, int count);

  /// No description provided for @receivesNow.
  ///
  /// In en, this message translates to:
  /// **'{name} receives now'**
  String receivesNow(String name);

  /// No description provided for @youReceiveNow.
  ///
  /// In en, this message translates to:
  /// **'You receive now'**
  String get youReceiveNow;

  /// No description provided for @nextTurnAt.
  ///
  /// In en, this message translates to:
  /// **'Next turn at {time}'**
  String nextTurnAt(String time);

  /// No description provided for @roundStartsAt.
  ///
  /// In en, this message translates to:
  /// **'The round starts at {time}'**
  String roundStartsAt(String time);

  /// No description provided for @roundEndingNow.
  ///
  /// In en, this message translates to:
  /// **'The last turn has ended. The room opens again in a moment.'**
  String get roundEndingNow;

  /// No description provided for @roundsFinished.
  ///
  /// In en, this message translates to:
  /// **'Finished rounds: {count}'**
  String roundsFinished(int count);

  /// No description provided for @startRoundNumber.
  ///
  /// In en, this message translates to:
  /// **'Start round {number}'**
  String startRoundNumber(int number);

  /// No description provided for @roundsHistory.
  ///
  /// In en, this message translates to:
  /// **'Rounds history'**
  String get roundsHistory;

  /// No description provided for @noRoundsYet.
  ///
  /// In en, this message translates to:
  /// **'No rounds yet. The history appears after the first round starts.'**
  String get noRoundsYet;

  /// No description provided for @roundStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get roundStatusActive;

  /// No description provided for @roundStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get roundStatusCompleted;

  /// No description provided for @roundDates.
  ///
  /// In en, this message translates to:
  /// **'{start} – {end}'**
  String roundDates(String start, String end);

  /// No description provided for @changeMemberCount.
  ///
  /// In en, this message translates to:
  /// **'Change number of members'**
  String get changeMemberCount;

  /// No description provided for @maxMembersSaved.
  ///
  /// In en, this message translates to:
  /// **'Number of members updated.'**
  String get maxMembersSaved;

  /// No description provided for @removeMember.
  ///
  /// In en, this message translates to:
  /// **'Remove from room'**
  String get removeMember;

  /// No description provided for @removeMemberConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from the room? Their payment history is kept.'**
  String removeMemberConfirm(String name);

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @memberRemoved.
  ///
  /// In en, this message translates to:
  /// **'{name} was removed.'**
  String memberRemoved(String name);

  /// No description provided for @leaveRoom.
  ///
  /// In en, this message translates to:
  /// **'Leave room'**
  String get leaveRoom;

  /// No description provided for @leaveRoomConfirm.
  ///
  /// In en, this message translates to:
  /// **'Leave this room? You can be invited again later.'**
  String get leaveRoomConfirm;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @late.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get late;

  /// No description provided for @nowLabel.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get nowLabel;

  /// No description provided for @fiveMinuteStartsNow.
  ///
  /// In en, this message translates to:
  /// **'Test room: the round starts now and the turn moves every 5 minutes.'**
  String get fiveMinuteStartsNow;

  /// No description provided for @betweenRoundsNote.
  ///
  /// In en, this message translates to:
  /// **'Between rounds you can invite people, change the number of members and remove members. Members can leave.'**
  String get betweenRoundsNote;

  /// No description provided for @owedBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'You owe {amounts} ({count} payments)'**
  String owedBannerTitle(String amounts, int count);

  /// No description provided for @owedBannerAction.
  ///
  /// In en, this message translates to:
  /// **'Tap to see them and mark them as paid.'**
  String get owedBannerAction;

  /// No description provided for @owedPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'What you owe'**
  String get owedPaymentsTitle;

  /// No description provided for @nothingOwed.
  ///
  /// In en, this message translates to:
  /// **'You don\'t owe anything right now.'**
  String get nothingOwed;

  /// No description provided for @owedTo.
  ///
  /// In en, this message translates to:
  /// **'To {name}'**
  String owedTo(String name);

  /// No description provided for @owedRoundTurn.
  ///
  /// In en, this message translates to:
  /// **'Round {round} · turn {turn}'**
  String owedRoundTurn(int round, int turn);

  /// No description provided for @removedFromRoomNote.
  ///
  /// In en, this message translates to:
  /// **'You are no longer in this room, but you still owe this payment.'**
  String get removedFromRoomNote;

  /// No description provided for @removedLabel.
  ///
  /// In en, this message translates to:
  /// **'Removed'**
  String get removedLabel;

  /// No description provided for @removeDuringRoundNotReceived.
  ///
  /// In en, this message translates to:
  /// **'{name} has not received yet. Their turn will be removed, the people after them move up, and nobody pays them. What they already owe stays.'**
  String removeDuringRoundNotReceived(String name);

  /// No description provided for @removeDuringRoundReceived.
  ///
  /// In en, this message translates to:
  /// **'{name} has already received. They will be removed but still owe the people after them, and JAMIA will keep reminding them.'**
  String removeDuringRoundReceived(String name);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['am', 'ar', 'en', 'fr', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
