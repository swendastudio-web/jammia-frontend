// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get languageName => 'Français';

  @override
  String get appTagline =>
      'Des cagnottes d\'épargne avec des personnes de confiance';

  @override
  String get chooseLanguageTitle => 'Choisissez votre langue';

  @override
  String get continueButton => 'Continuer';

  @override
  String get language => 'Langue';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get logIn => 'Se connecter';

  @override
  String get noAccountSignUp => 'Pas de compte ? Inscrivez-vous';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get passwordHelper => '8 à 72 caractères';

  @override
  String get emailRequired => 'L\'e-mail est obligatoire';

  @override
  String get emailInvalid => 'Entrez une adresse e-mail valide';

  @override
  String get passwordRequired => 'Le mot de passe est obligatoire';

  @override
  String get passwordLength =>
      'Le mot de passe doit contenir 8 à 72 caractères';

  @override
  String get firstNameRequired => 'Le prénom est obligatoire';

  @override
  String get lastNameRequired => 'Le nom est obligatoire';

  @override
  String get nameRequired => 'Le nom est obligatoire';

  @override
  String get amountRequired => 'Le montant est obligatoire';

  @override
  String get amountAboveZero => 'Entrez un montant supérieur à 0';

  @override
  String get amountDecimals => '2 décimales maximum';

  @override
  String get currencyLetters => '3 lettres';

  @override
  String get enterNumber => 'Entrez un nombre';

  @override
  String get minTwoMembers => 'Une cagnotte a besoin d\'au moins 2 membres';

  @override
  String planAllowsUpTo(int count) {
    return 'Votre formule permet jusqu\'à $count membres';
  }

  @override
  String get phoneFormat =>
      'Utilisez le format international, ex. +96891234567';

  @override
  String get currentPasswordRequired =>
      'Le mot de passe actuel est obligatoire';

  @override
  String get errorNetwork =>
      'Impossible de joindre le serveur JAMIA. Vérifiez votre connexion et que le serveur fonctionne.';

  @override
  String get errorTimeout =>
      'Le serveur JAMIA a mis trop de temps à répondre. Réessayez.';

  @override
  String get errorSessionExpired =>
      'Votre session a expiré. Veuillez vous reconnecter.';

  @override
  String errorGeneric(int code) {
    return 'Une erreur s\'est produite (erreur $code).';
  }

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get myRooms => 'Mes cagnottes';

  @override
  String get profile => 'Profil';

  @override
  String get newRoom => 'Nouvelle cagnotte';

  @override
  String get noRoomsTitle => 'Aucune cagnotte pour l\'instant';

  @override
  String get noRoomsMessage =>
      'Créez une cagnotte ou rejoignez-en une avec le lien d\'invitation d\'un ami.';

  @override
  String get joinWithInviteLink => 'Rejoindre avec un lien d\'invitation';

  @override
  String get creator => 'Créateur';

  @override
  String roomCardSubtitle(String amount, String frequency, int max) {
    return '$amount · $frequency · jusqu\'à $max membres';
  }

  @override
  String get statusOpen => 'Ouverte';

  @override
  String get statusActive => 'Active';

  @override
  String get statusCompleted => 'Terminée';

  @override
  String get frequencyWeekly => 'Chaque semaine';

  @override
  String get frequencyBiweekly => 'Toutes les 2 semaines';

  @override
  String get frequencyMonthly => 'Chaque mois';

  @override
  String get paymentNotPaid => 'Non payé';

  @override
  String get paymentPaid => 'Payé';

  @override
  String get paymentReceived => 'Reçu';

  @override
  String get roomName => 'Nom de la cagnotte';

  @override
  String get descriptionOptional => 'Description (facultatif)';

  @override
  String get amountPerPerson => 'Montant par personne';

  @override
  String get currency => 'Devise';

  @override
  String get howOften => 'Fréquence';

  @override
  String get maximumMembers => 'Nombre maximum de membres';

  @override
  String planAllowsHelper(String plan, int count) {
    return 'Votre formule $plan permet jusqu\'à $count membres';
  }

  @override
  String get createRoom => 'Créer la cagnotte';

  @override
  String get inviteLink => 'Lien d\'invitation';

  @override
  String get showRoom => 'Afficher la cagnotte';

  @override
  String get pasteInviteLink =>
      'Collez le lien d\'invitation que vous avez reçu.';

  @override
  String get alreadyMember => 'Vous êtes déjà membre de cette cagnotte.';

  @override
  String get requestSent =>
      'Demande envoyée. Le créateur l\'acceptera ou la refusera.';

  @override
  String get requestToJoin => 'Demander à rejoindre';

  @override
  String get referredBy => 'Parrainé par';

  @override
  String get createdBy => 'Créée par';

  @override
  String get amount => 'Montant';

  @override
  String amountPerPersonValue(String amount) {
    return '$amount par personne';
  }

  @override
  String get members => 'Membres';

  @override
  String countOfMax(int count, int max) {
    return '$count sur $max';
  }

  @override
  String get room => 'Cagnotte';

  @override
  String get perPersonEachCycle => 'par personne, à chaque cycle';

  @override
  String get totalEachCycle => 'Total par cycle';

  @override
  String totalUpTo(String amount, int count) {
    return 'Jusqu\'à $amount (avec $count membres)';
  }

  @override
  String get firstDueDate => 'Première échéance';

  @override
  String get turnOrder => 'Ordre des tours';

  @override
  String get turnOrderRandom => 'Aléatoire';

  @override
  String get turnOrderManual => 'Choisi par le créateur';

  @override
  String get invitePeople => 'Inviter des personnes';

  @override
  String get startRoom => 'Démarrer la cagnotte';

  @override
  String get startRoomNeedsMembers => 'Démarrer (au moins 2 membres)';

  @override
  String get payments => 'Paiements';

  @override
  String joinRequestsTitle(int count) {
    return 'Demandes d\'adhésion ($count)';
  }

  @override
  String get noJoinRequests =>
      'Personne n\'attend. Les demandes apparaissent ici quand quelqu\'un utilise un lien d\'invitation.';

  @override
  String referredByName(String name) {
    return 'Parrainé par $name';
  }

  @override
  String askedAt(String date) {
    return 'Demandé le $date';
  }

  @override
  String get reject => 'Refuser';

  @override
  String get accept => 'Accepter';

  @override
  String nowMember(String name) {
    return '$name est maintenant membre.';
  }

  @override
  String requestRejected(String name) {
    return 'Demande de $name refusée.';
  }

  @override
  String membersTitle(int count, int max) {
    return 'Membres ($count sur $max)';
  }

  @override
  String nameYou(String name) {
    return '$name (vous)';
  }

  @override
  String get turnDecidedLater => 'Tour décidé au démarrage';

  @override
  String turnInfo(int turn) {
    return 'Tour $turn · reçoit au cycle $turn';
  }

  @override
  String get yourInviteLink => 'Votre lien d\'invitation';

  @override
  String get inviteLinkExplanation =>
      'Toute personne qui l\'ouvre peut demander à rejoindre. Le créateur accepte ou refuse chaque demande et voit que vous l\'avez parrainée.';

  @override
  String worksUntil(String date) {
    return 'Valable jusqu\'au $date';
  }

  @override
  String get copyLink => 'Copier le lien';

  @override
  String get linkCopied =>
      'Lien copié. Collez-le dans WhatsApp, Facebook, Instagram ou par SMS.';

  @override
  String get randomOption => 'Aléatoire';

  @override
  String get iChoose => 'Je choisis';

  @override
  String get randomExplanation =>
      'JAMIA mélange les membres équitablement au démarrage.';

  @override
  String get manualExplanation =>
      'Faites glisser les membres pour fixer l\'ordre. Le premier reçoit en premier.';

  @override
  String get order => 'Ordre';

  @override
  String turnNumber(int turn) {
    return 'Tour $turn';
  }

  @override
  String get startRoomConfirmTitle => 'Démarrer la cagnotte ?';

  @override
  String get startRoomConfirmMessage =>
      'Après le démarrage, personne ne peut rejoindre et l\'ordre ne peut plus changer. Les demandes en attente seront refusées.';

  @override
  String get cancel => 'Annuler';

  @override
  String get start => 'Démarrer';

  @override
  String get noPaymentsTitle => 'Aucun paiement pour l\'instant';

  @override
  String get noPaymentsMessage =>
      'Le calendrier apparaît quand le créateur démarre la cagnotte.';

  @override
  String get noMoneyNote =>
      'JAMIA ne transfère pas d\'argent. Les membres se paient hors de l\'application et l\'enregistrent ici.';

  @override
  String cycleHeader(int cycle, String date) {
    return 'Cycle $cycle · $date';
  }

  @override
  String receivedCount(int done, int total) {
    return '$done/$total reçus';
  }

  @override
  String youReceiveTotal(String amount) {
    return 'Vous recevez $amount au total (votre part incluse)';
  }

  @override
  String personReceivesTotal(String name, String amount) {
    return '$name reçoit $amount au total (sa part incluse)';
  }

  @override
  String get youPay => 'Vous payez';

  @override
  String personPays(String name) {
    return '$name paie';
  }

  @override
  String get iPaid => 'J\'ai payé';

  @override
  String get iReceivedIt => 'Je l\'ai reçu';

  @override
  String get confirmReceivedTitle => 'Confirmer la réception ?';

  @override
  String confirmReceivedMessage(String amount, String name) {
    return '$amount de $name.';
  }

  @override
  String get yesReceived => 'Oui, reçu';

  @override
  String get plan => 'Formule';

  @override
  String get role => 'Rôle';

  @override
  String get adminRole => 'Administrateur JAMIA';

  @override
  String get phoneOptional => 'Téléphone (facultatif)';

  @override
  String get save => 'Enregistrer';

  @override
  String get profileSaved => 'Profil enregistré.';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get logOut => 'Se déconnecter';

  @override
  String get currentPassword => 'Mot de passe actuel';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get passwordChanged =>
      'Mot de passe changé. Vos autres appareils ont été déconnectés.';

  @override
  String get frequencyFiveMinutes => 'Toutes les 5 minutes (test)';

  @override
  String roundTitle(int number) {
    return 'Tour de rotation $number';
  }

  @override
  String turnOfCount(int turn, int count) {
    return 'Tour $turn sur $count';
  }

  @override
  String receivesNow(String name) {
    return '$name reçoit maintenant';
  }

  @override
  String get youReceiveNow => 'Vous recevez maintenant';

  @override
  String nextTurnAt(String time) {
    return 'Tour suivant à $time';
  }

  @override
  String roundStartsAt(String time) {
    return 'La rotation commence à $time';
  }

  @override
  String get roundEndingNow =>
      'Le dernier tour est terminé. La cagnotte rouvre dans un instant.';

  @override
  String roundsFinished(int count) {
    return 'Rotations terminées : $count';
  }

  @override
  String startRoundNumber(int number) {
    return 'Démarrer la rotation $number';
  }

  @override
  String get roundsHistory => 'Historique des rotations';

  @override
  String get noRoundsYet =>
      'Aucune rotation pour l\'instant. L\'historique apparaît après la première.';

  @override
  String get roundStatusActive => 'En cours';

  @override
  String get roundStatusCompleted => 'Terminée';

  @override
  String roundDates(String start, String end) {
    return '$start – $end';
  }

  @override
  String get changeMemberCount => 'Modifier le nombre de membres';

  @override
  String get maxMembersSaved => 'Nombre de membres mis à jour.';

  @override
  String get removeMember => 'Retirer de la cagnotte';

  @override
  String removeMemberConfirm(String name) {
    return 'Retirer $name de la cagnotte ? Son historique de paiements est conservé.';
  }

  @override
  String get remove => 'Retirer';

  @override
  String memberRemoved(String name) {
    return '$name a été retiré.';
  }

  @override
  String get leaveRoom => 'Quitter la cagnotte';

  @override
  String get leaveRoomConfirm =>
      'Quitter cette cagnotte ? Vous pourrez être réinvité plus tard.';

  @override
  String get leave => 'Quitter';

  @override
  String get late => 'En retard';

  @override
  String get nowLabel => 'Maintenant';

  @override
  String get fiveMinuteStartsNow =>
      'Cagnotte de test : la rotation commence maintenant et le tour change toutes les 5 minutes.';

  @override
  String get betweenRoundsNote =>
      'Entre deux rotations, vous pouvez inviter, changer le nombre de membres et retirer des membres. Les membres peuvent partir.';

  @override
  String owedBannerTitle(String amounts, int count) {
    return 'Vous devez $amounts ($count paiements)';
  }

  @override
  String get owedBannerAction =>
      'Touchez pour les voir et les marquer comme payés.';

  @override
  String get owedPaymentsTitle => 'Ce que vous devez';

  @override
  String get nothingOwed => 'Vous ne devez rien pour le moment.';

  @override
  String owedTo(String name) {
    return 'À $name';
  }

  @override
  String owedRoundTurn(int round, int turn) {
    return 'Rotation $round · tour $turn';
  }

  @override
  String get removedFromRoomNote =>
      'Vous ne faites plus partie de cette cagnotte, mais vous devez encore ce paiement.';

  @override
  String get removedLabel => 'Retiré';

  @override
  String removeDuringRoundNotReceived(String name) {
    return '$name n\'a pas encore reçu. Son tour sera supprimé, les suivants avancent et personne ne le paie. Ce qu\'il doit déjà reste dû.';
  }

  @override
  String removeDuringRoundReceived(String name) {
    return '$name a déjà reçu. Il sera retiré mais doit encore payer les suivants, et JAMIA continuera à le lui rappeler.';
  }
}
