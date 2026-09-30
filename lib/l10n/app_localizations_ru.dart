// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get languageName => 'Русский';

  @override
  String get appTagline =>
      'Сберегательные комнаты с людьми, которым вы доверяете';

  @override
  String get chooseLanguageTitle => 'Выберите язык';

  @override
  String get continueButton => 'Продолжить';

  @override
  String get language => 'Язык';

  @override
  String get email => 'Эл. почта';

  @override
  String get password => 'Пароль';

  @override
  String get firstName => 'Имя';

  @override
  String get lastName => 'Фамилия';

  @override
  String get logIn => 'Войти';

  @override
  String get noAccountSignUp => 'Нет аккаунта? Зарегистрируйтесь';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get passwordHelper => 'От 8 до 72 символов';

  @override
  String get emailRequired => 'Укажите эл. почту';

  @override
  String get emailInvalid => 'Введите правильный адрес эл. почты';

  @override
  String get passwordRequired => 'Введите пароль';

  @override
  String get passwordLength => 'Пароль должен содержать от 8 до 72 символов';

  @override
  String get firstNameRequired => 'Укажите имя';

  @override
  String get lastNameRequired => 'Укажите фамилию';

  @override
  String get nameRequired => 'Укажите название';

  @override
  String get amountRequired => 'Укажите сумму';

  @override
  String get amountAboveZero => 'Введите сумму больше 0';

  @override
  String get amountDecimals => 'Не более 2 знаков после запятой';

  @override
  String get currencyLetters => '3 буквы';

  @override
  String get enterNumber => 'Введите число';

  @override
  String get minTwoMembers => 'В комнате должно быть не менее 2 участников';

  @override
  String planAllowsUpTo(int count) {
    return 'Ваш тариф позволяет до $count участников';
  }

  @override
  String get phoneFormat =>
      'Используйте международный формат, например +96891234567';

  @override
  String get currentPasswordRequired => 'Введите текущий пароль';

  @override
  String get errorNetwork =>
      'Не удаётся связаться с сервером JAMIA. Проверьте подключение и работу сервера.';

  @override
  String get errorTimeout =>
      'Сервер JAMIA слишком долго отвечает. Попробуйте ещё раз.';

  @override
  String get errorSessionExpired => 'Сеанс истёк. Войдите снова.';

  @override
  String errorGeneric(int code) {
    return 'Что-то пошло не так (ошибка $code).';
  }

  @override
  String get tryAgain => 'Повторить';

  @override
  String get myRooms => 'Мои комнаты';

  @override
  String get profile => 'Профиль';

  @override
  String get newRoom => 'Новая комната';

  @override
  String get noRoomsTitle => 'Пока нет комнат';

  @override
  String get noRoomsMessage =>
      'Создайте сберегательную комнату или присоединитесь по ссылке-приглашению от друга.';

  @override
  String get joinWithInviteLink => 'Присоединиться по ссылке';

  @override
  String get creator => 'Создатель';

  @override
  String roomCardSubtitle(String amount, String frequency, int max) {
    return '$amount · $frequency · до $max участников';
  }

  @override
  String get statusOpen => 'Открыта';

  @override
  String get statusActive => 'Активна';

  @override
  String get statusCompleted => 'Завершена';

  @override
  String get frequencyWeekly => 'Еженедельно';

  @override
  String get frequencyBiweekly => 'Раз в 2 недели';

  @override
  String get frequencyMonthly => 'Ежемесячно';

  @override
  String get paymentNotPaid => 'Не оплачено';

  @override
  String get paymentPaid => 'Оплачено';

  @override
  String get paymentReceived => 'Получено';

  @override
  String get roomName => 'Название комнаты';

  @override
  String get descriptionOptional => 'Описание (необязательно)';

  @override
  String get amountPerPerson => 'Сумма с человека';

  @override
  String get currency => 'Валюта';

  @override
  String get howOften => 'Как часто';

  @override
  String get maximumMembers => 'Максимум участников';

  @override
  String planAllowsHelper(String plan, int count) {
    return 'Тариф $plan позволяет до $count участников';
  }

  @override
  String get createRoom => 'Создать комнату';

  @override
  String get inviteLink => 'Ссылка-приглашение';

  @override
  String get showRoom => 'Показать комнату';

  @override
  String get pasteInviteLink => 'Вставьте полученную ссылку-приглашение.';

  @override
  String get alreadyMember => 'Вы уже участник этой комнаты.';

  @override
  String get requestSent =>
      'Запрос отправлен. Создатель комнаты примет или отклонит его.';

  @override
  String get requestToJoin => 'Запросить вступление';

  @override
  String get referredBy => 'Пригласил(а)';

  @override
  String get createdBy => 'Создатель';

  @override
  String get amount => 'Сумма';

  @override
  String amountPerPersonValue(String amount) {
    return '$amount с человека';
  }

  @override
  String get members => 'Участники';

  @override
  String countOfMax(int count, int max) {
    return '$count из $max';
  }

  @override
  String get room => 'Комната';

  @override
  String get perPersonEachCycle => 'с человека за каждый цикл';

  @override
  String get totalEachCycle => 'Итого за цикл';

  @override
  String totalUpTo(String amount, int count) {
    return 'До $amount (при $count участниках)';
  }

  @override
  String get firstDueDate => 'Первый срок оплаты';

  @override
  String get turnOrder => 'Порядок очереди';

  @override
  String get turnOrderRandom => 'Случайный';

  @override
  String get turnOrderManual => 'Выбран создателем';

  @override
  String get invitePeople => 'Пригласить людей';

  @override
  String get startRoom => 'Запустить комнату';

  @override
  String get startRoomNeedsMembers => 'Запустить (нужно не менее 2 участников)';

  @override
  String get payments => 'Платежи';

  @override
  String joinRequestsTitle(int count) {
    return 'Запросы на вступление ($count)';
  }

  @override
  String get noJoinRequests =>
      'Никто не ждёт. Запросы появятся здесь, когда кто-то воспользуется ссылкой.';

  @override
  String referredByName(String name) {
    return 'Пригласил(а): $name';
  }

  @override
  String askedAt(String date) {
    return 'Запрос: $date';
  }

  @override
  String get reject => 'Отклонить';

  @override
  String get accept => 'Принять';

  @override
  String nowMember(String name) {
    return '$name теперь участник.';
  }

  @override
  String requestRejected(String name) {
    return 'Запрос от $name отклонён.';
  }

  @override
  String membersTitle(int count, int max) {
    return 'Участники ($count из $max)';
  }

  @override
  String nameYou(String name) {
    return '$name (вы)';
  }

  @override
  String get turnDecidedLater => 'Очередь определится при запуске';

  @override
  String turnInfo(int turn) {
    return 'Очередь $turn · получает в цикле $turn';
  }

  @override
  String get yourInviteLink => 'Ваша ссылка-приглашение';

  @override
  String get inviteLinkExplanation =>
      'Любой, кто откроет её, сможет запросить вступление. Создатель комнаты принимает или отклоняет каждый запрос и видит, что пригласили вы.';

  @override
  String worksUntil(String date) {
    return 'Действует до $date';
  }

  @override
  String get copyLink => 'Копировать ссылку';

  @override
  String get linkCopied =>
      'Ссылка скопирована. Вставьте её в WhatsApp, Facebook, Instagram или SMS.';

  @override
  String get randomOption => 'Случайно';

  @override
  String get iChoose => 'Я выберу';

  @override
  String get randomExplanation =>
      'JAMIA честно перемешает участников при запуске.';

  @override
  String get manualExplanation =>
      'Перетащите участников, чтобы задать порядок. Первый получает первым.';

  @override
  String get order => 'Порядок';

  @override
  String turnNumber(int turn) {
    return 'Очередь $turn';
  }

  @override
  String get startRoomConfirmTitle => 'Запустить комнату?';

  @override
  String get startRoomConfirmMessage =>
      'После запуска никто не сможет вступить, а порядок нельзя будет изменить. Ожидающие запросы будут отклонены.';

  @override
  String get cancel => 'Отмена';

  @override
  String get start => 'Запустить';

  @override
  String get noPaymentsTitle => 'Платежей пока нет';

  @override
  String get noPaymentsMessage =>
      'График появится, когда создатель запустит комнату.';

  @override
  String get noMoneyNote =>
      'JAMIA не переводит деньги. Участники платят друг другу вне приложения и отмечают это здесь.';

  @override
  String cycleHeader(int cycle, String date) {
    return 'Цикл $cycle · $date';
  }

  @override
  String receivedCount(int done, int total) {
    return 'получено $done/$total';
  }

  @override
  String youReceiveTotal(String amount) {
    return 'Вы получаете всего $amount (включая свою долю)';
  }

  @override
  String personReceivesTotal(String name, String amount) {
    return '$name получает всего $amount (включая свою долю)';
  }

  @override
  String get youPay => 'Вы платите';

  @override
  String personPays(String name) {
    return '$name платит';
  }

  @override
  String get iPaid => 'Я оплатил(а)';

  @override
  String get iReceivedIt => 'Я получил(а)';

  @override
  String get confirmReceivedTitle => 'Подтвердить получение?';

  @override
  String confirmReceivedMessage(String amount, String name) {
    return '$amount от $name.';
  }

  @override
  String get yesReceived => 'Да, получено';

  @override
  String get plan => 'Тариф';

  @override
  String get role => 'Роль';

  @override
  String get adminRole => 'Администратор JAMIA';

  @override
  String get phoneOptional => 'Телефон (необязательно)';

  @override
  String get save => 'Сохранить';

  @override
  String get profileSaved => 'Профиль сохранён.';

  @override
  String get changePassword => 'Сменить пароль';

  @override
  String get logOut => 'Выйти';

  @override
  String get currentPassword => 'Текущий пароль';

  @override
  String get newPassword => 'Новый пароль';

  @override
  String get passwordChanged =>
      'Пароль изменён. На других устройствах выполнен выход.';

  @override
  String get frequencyFiveMinutes => 'Каждые 5 минут (тест)';

  @override
  String roundTitle(int number) {
    return 'Раунд $number';
  }

  @override
  String turnOfCount(int turn, int count) {
    return 'Очередь $turn из $count';
  }

  @override
  String receivesNow(String name) {
    return 'Сейчас получает $name';
  }

  @override
  String get youReceiveNow => 'Сейчас получаете вы';

  @override
  String nextTurnAt(String time) {
    return 'Следующая очередь в $time';
  }

  @override
  String roundStartsAt(String time) {
    return 'Раунд начнётся в $time';
  }

  @override
  String get roundEndingNow =>
      'Последняя очередь закончилась. Комната скоро снова откроется.';

  @override
  String roundsFinished(int count) {
    return 'Завершённых раундов: $count';
  }

  @override
  String startRoundNumber(int number) {
    return 'Начать раунд $number';
  }

  @override
  String get roundsHistory => 'История раундов';

  @override
  String get noRoundsYet =>
      'Раундов пока нет. История появится после начала первого раунда.';

  @override
  String get roundStatusActive => 'Идёт';

  @override
  String get roundStatusCompleted => 'Завершён';

  @override
  String roundDates(String start, String end) {
    return '$start – $end';
  }

  @override
  String get changeMemberCount => 'Изменить число участников';

  @override
  String get maxMembersSaved => 'Число участников обновлено.';

  @override
  String get removeMember => 'Удалить из комнаты';

  @override
  String removeMemberConfirm(String name) {
    return 'Удалить $name из комнаты? История платежей сохранится.';
  }

  @override
  String get remove => 'Удалить';

  @override
  String memberRemoved(String name) {
    return '$name удалён(а).';
  }

  @override
  String get leaveRoom => 'Покинуть комнату';

  @override
  String get leaveRoomConfirm =>
      'Покинуть комнату? Позже вас можно будет пригласить снова.';

  @override
  String get leave => 'Покинуть';

  @override
  String get late => 'Просрочено';

  @override
  String get nowLabel => 'Сейчас';

  @override
  String get fiveMinuteStartsNow =>
      'Тестовая комната: раунд начнётся сейчас, очередь меняется каждые 5 минут.';

  @override
  String get betweenRoundsNote =>
      'Между раундами можно приглашать людей, менять число участников и удалять участников. Участники могут выйти.';

  @override
  String owedBannerTitle(String amounts, int count) {
    return 'Вы должны $amounts (платежей: $count)';
  }

  @override
  String get owedBannerAction => 'Нажмите, чтобы посмотреть и отметить оплату.';

  @override
  String get owedPaymentsTitle => 'Ваши долги';

  @override
  String get nothingOwed => 'Сейчас вы ничего не должны.';

  @override
  String owedTo(String name) {
    return 'Кому: $name';
  }

  @override
  String owedRoundTurn(int round, int turn) {
    return 'Раунд $round · очередь $turn';
  }

  @override
  String get removedFromRoomNote =>
      'Вы больше не в этой комнате, но этот платёж всё ещё за вами.';

  @override
  String get removedLabel => 'Удалён';

  @override
  String removeDuringRoundNotReceived(String name) {
    return '$name ещё не получал(а). Его очередь будет удалена, следующие сдвинутся вперёд, и никто ему не платит. Уже накопленный долг остаётся.';
  }

  @override
  String removeDuringRoundReceived(String name) {
    return '$name уже получил(а). Участник будет удалён, но останется должен следующим, и JAMIA будет напоминать об этом.';
  }
}
