/// A member's personal invite link (matches InviteLinkResponse).
class InviteLink {
  final String token;
  final String url;
  final DateTime expiresAt;

  const InviteLink({required this.token, required this.url, required this.expiresAt});

  factory InviteLink.fromJson(Map<String, dynamic> json) {
    return InviteLink(
      token: json['token'] as String,
      url: json['url'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }
}

/// What someone sees after opening an invite link (matches InvitePreviewResponse).
class InvitePreview {
  final String roomName;
  final String? roomDescription;
  final num contributionAmount;
  final String currency;
  final String frequency;
  final int memberCount;
  final int maxMembers;
  final String creatorName;
  final String referredByName;
  final bool alreadyMember;
  final bool requestPending;

  const InvitePreview({
    required this.roomName,
    required this.roomDescription,
    required this.contributionAmount,
    required this.currency,
    required this.frequency,
    required this.memberCount,
    required this.maxMembers,
    required this.creatorName,
    required this.referredByName,
    required this.alreadyMember,
    required this.requestPending,
  });

  factory InvitePreview.fromJson(Map<String, dynamic> json) {
    return InvitePreview(
      roomName: json['roomName'] as String,
      roomDescription: json['roomDescription'] as String?,
      contributionAmount: json['contributionAmount'] as num,
      currency: json['currency'] as String,
      frequency: json['frequency'] as String,
      memberCount: json['memberCount'] as int,
      maxMembers: json['maxMembers'] as int,
      creatorName: json['creatorName'] as String,
      referredByName: json['referredByName'] as String,
      alreadyMember: json['alreadyMember'] as bool,
      requestPending: json['requestPending'] as bool,
    );
  }
}

/// A request to join, as the room creator sees it: who asks and who referred them
/// (matches JoinRequestResponse).
class JoinRequest {
  final int id;
  final String requesterName;
  final String referredByName;
  final String status;
  final DateTime createdAt;

  const JoinRequest({
    required this.id,
    required this.requesterName,
    required this.referredByName,
    required this.status,
    required this.createdAt,
  });

  factory JoinRequest.fromJson(Map<String, dynamic> json) {
    return JoinRequest(
      id: json['id'] as int,
      requesterName: '${json['requesterFirstName']} ${json['requesterLastName']}',
      referredByName: '${json['referredByFirstName']} ${json['referredByLastName']}',
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
