/// A room member as other members see them (matches RoomMemberResponse).
class RoomMember {
  final int userId;
  final String firstName;
  final String lastName;
  final int? turnPosition;
  final bool hasProfilePhoto;

  const RoomMember({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.turnPosition,
    required this.hasProfilePhoto,
  });

  String get fullName => '$firstName $lastName';

  factory RoomMember.fromJson(Map<String, dynamic> json) {
    return RoomMember(
      userId: json['userId'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      turnPosition: json['turnPosition'] as int?,
      hasProfilePhoto: json['hasProfilePhoto'] as bool,
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

/// One room with its members (matches RoomResponse).
class Room {
  final int id;
  final String name;
  final String? description;
  final num contributionAmount;
  final String currency;
  final String frequency;
  final int maxMembers;
  final String status;
  final String? turnOrderMethod;
  final DateTime? startDate;
  final int creatorUserId;
  final List<RoomMember> members;

  const Room({
    required this.id,
    required this.name,
    required this.description,
    required this.contributionAmount,
    required this.currency,
    required this.frequency,
    required this.maxMembers,
    required this.status,
    required this.turnOrderMethod,
    required this.startDate,
    required this.creatorUserId,
    required this.members,
  });

  bool get isOpen => status == 'OPEN';

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
      turnOrderMethod: json['turnOrderMethod'] as String?,
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'] as String),
      creatorUserId: json['creatorUserId'] as int,
      members: (json['members'] as List<dynamic>)
          .map((m) => RoomMember.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }
}
