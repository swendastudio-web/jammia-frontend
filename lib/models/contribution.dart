import 'room.dart';

/// One member's payment for one cycle (matches ContributionResponse).
/// JAMIA does not move money: this only shows what members report.
class Contribution {
  final int id;
  final int roundNumber;
  final int cycleNumber;
  final DateTime dueAt; // when this turn begins
  final DateTime turnEndsAt; // when the turn moves to the next person
  final RoomMember payer;
  final RoomMember recipient;
  final num amount;
  final String status;
  final bool late; // the turn has passed and it is still not paid

  const Contribution({
    required this.id,
    required this.roundNumber,
    required this.cycleNumber,
    required this.dueAt,
    required this.turnEndsAt,
    required this.payer,
    required this.recipient,
    required this.amount,
    required this.status,
    required this.late,
  });

  factory Contribution.fromJson(Map<String, dynamic> json) {
    return Contribution(
      id: json['id'] as int,
      roundNumber: json['roundNumber'] as int,
      cycleNumber: json['cycleNumber'] as int,
      dueAt: DateTime.parse(json['dueAt'] as String),
      turnEndsAt: DateTime.parse(json['turnEndsAt'] as String),
      payer: RoomMember.fromJson(json['payer'] as Map<String, dynamic>),
      recipient: RoomMember.fromJson(json['recipient'] as Map<String, dynamic>),
      amount: json['amount'] as num,
      status: json['status'] as String,
      late: json['late'] as bool,
    );
  }
}
