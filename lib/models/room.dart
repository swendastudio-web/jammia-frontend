/// A room member as other members see them (matches RoomMemberResponse).
class RoomMember {
  final int userId;
  final String firstName;
  final String lastName;
  final int? turnPosition;
  final bool hasProfilePhoto;
  final bool active; // false = removed from (or left) the room, e.g. a payer who still owes

  const RoomMember({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.turnPosition,
    required this.hasProfilePhoto,
    this.active = true,
  });

  String get fullName => '$firstName $lastName';

  factory RoomMember.fromJson(Map<String, dynamic> json) {
    return RoomMember(
      userId: json['userId'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      turnPosition: json['turnPosition'] as int?,
      hasProfilePhoto: json['hasProfilePhoto'] as bool,
      active: (json['active'] as bool?) ?? true,
    );
  }
}

/// A room in the "my rooms" list (matches RoomSummaryResponse).
class RoomSummary {
  final int id;
  final String name;
  final num contributionAmount;
  final String currency;
  final String frequency;
  final int maxMembers;
  final String status;
  final bool createdByMe;

  const RoomSummary({
    required this.id,
    required this.name,
    required this.contributionAmount,
    required this.currency,
    required this.frequency,
    required this.maxMembers,
    required this.status,
    required this.createdByMe,
  });

  factory RoomSummary.fromJson(Map<String, dynamic> json) {
    return RoomSummary(
      id: json['id'] as int,
      name: json['name'] as String,
      contributionAmount: json['contributionAmount'] as num,
      currency: json['currency'] as String,
      frequency: json['frequency'] as String,
      maxMembers: json['maxMembers'] as int,
      status: json['status'] as String,
      createdByMe: json['createdByMe'] as bool,
    );
  }
}

/// One round (rotation) of a room (matches RoundResponse).
class RoomRound {
  final int roundNumber;
  final String status; // ACTIVE or COMPLETED
  final String turnOrderMethod;
  final DateTime startedAt;
  final DateTime endsAt;
  final DateTime? completedAt;
  final int turnCount;
  final int currentTurn; // 0 = not begun, 1..turnCount = running, turnCount + 1 = all passed
  final int? currentRecipientUserId;
  final DateTime? currentTurnEndsAt;
  final int paymentsTotal;
  final int paymentsReceived;

  const RoomRound({
    required this.roundNumber,
    required this.status,
    required this.turnOrderMethod,
    required this.startedAt,
    required this.endsAt,
    required this.completedAt,
    required this.turnCount,
    required this.currentTurn,
    required this.currentRecipientUserId,
    required this.currentTurnEndsAt,
    required this.paymentsTotal,
    required this.paymentsReceived,
  });

  bool get isRunning => status == 'ACTIVE';

  factory RoomRound.fromJson(Map<String, dynamic> json) {
    DateTime? date(String key) => json[key] == null ? null : DateTime.parse(json[key] as String);
    return RoomRound(
      roundNumber: json['roundNumber'] as int,
      status: json['status'] as String,
      turnOrderMethod: json['turnOrderMethod'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      completedAt: date('completedAt'),
      turnCount: json['turnCount'] as int,
      currentTurn: json['currentTurn'] as int,
      currentRecipientUserId: json['currentRecipientUserId'] as int?,
      currentTurnEndsAt: date('currentTurnEndsAt'),
      paymentsTotal: json['paymentsTotal'] as int,
      paymentsReceived: json['paymentsReceived'] as int,
    );
  }
}

/// One room with its members and its current round (matches RoomResponse).
class Room {
  final int id;
  final String name;
  final String? description;
  final num contributionAmount;
  final String currency;
  final String frequency;
  final int maxMembers;
  final String status;
  final int creatorUserId;
  final List<RoomMember> members;
  final RoomRound? currentRound;
  final int completedRounds;

  const Room({
    required this.id,
    required this.name,
    required this.description,
    required this.contributionAmount,
    required this.currency,
    required this.frequency,
    required this.maxMembers,
    required this.status,
    required this.creatorUserId,
    required this.members,
    required this.currentRound,
    required this.completedRounds,
  });

  bool get isOpen => status == 'OPEN';
  bool get isFiveMinuteTest => frequency == 'FIVE_MINUTES';

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      contributionAmount: json['contributionAmount'] as num,
      currency: json['currency'] as String,
      frequency: json['frequency'] as String,
      maxMembers: json['maxMembers'] as int,
      status: json['status'] as String,
      creatorUserId: json['creatorUserId'] as int,
      members: (json['members'] as List<dynamic>)
          .map((m) => RoomMember.fromJson(m as Map<String, dynamic>))
          .toList(),
      currentRound: json['currentRound'] == null
          ? null
          : RoomRound.fromJson(json['currentRound'] as Map<String, dynamic>),
      completedRounds: json['completedRounds'] as int,
    );
  }
}
