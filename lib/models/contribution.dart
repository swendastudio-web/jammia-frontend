import 'room.dart';

/// One member's payment for one cycle (matches ContributionResponse).
/// JAMIA does not move money: this only shows what members report.
class Contribution {
  final int id;
  final int cycleNumber;
  final DateTime dueDate;
  final RoomMember payer;
  final RoomMember recipient;
  final num amount;
  final String status;

  const Contribution({
    required this.id,
    required this.cycleNumber,
    required this.dueDate,
    required this.payer,
    required this.recipient,
    required this.amount,
    required this.status,
  });

  factory Contribution.fromJson(Map<String, dynamic> json) {
    return Contribution(
      id: json['id'] as int,
      cycleNumber: json['cycleNumber'] as int,
      dueDate: DateTime.parse(json['dueDate'] as String),
      payer: RoomMember.fromJson(json['payer'] as Map<String, dynamic>),
      recipient: RoomMember.fromJson(json['recipient'] as Map<String, dynamic>),
      amount: json['amount'] as num,
      status: json['status'] as String,
    );
  }
}
