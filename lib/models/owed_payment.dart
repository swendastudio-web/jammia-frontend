/// A payment the user still has to make (its turn has started) — for the "You owe" reminder
/// (matches OwedPaymentResponse). Also for rooms the user was removed from.
class OwedPayment {
  final int contributionId;
  final int roomId;
  final String roomName;
  final String currency;
  final int roundNumber;
  final int cycleNumber;
  final DateTime dueAt;
  final String recipientName;
  final num amount;
  final bool late;
  final bool stillMember;

  const OwedPayment({
    required this.contributionId,
    required this.roomId,
    required this.roomName,
    required this.currency,
    required this.roundNumber,
    required this.cycleNumber,
    required this.dueAt,
    required this.recipientName,
    required this.amount,
    required this.late,
    required this.stillMember,
  });

  factory OwedPayment.fromJson(Map<String, dynamic> json) {
    return OwedPayment(
      contributionId: json['contributionId'] as int,
      roomId: json['roomId'] as int,
      roomName: json['roomName'] as String,
      currency: json['currency'] as String,
      roundNumber: json['roundNumber'] as int,
      cycleNumber: json['cycleNumber'] as int,
      dueAt: DateTime.parse(json['dueAt'] as String),
      recipientName: json['recipientName'] as String,
      amount: json['amount'] as num,
      late: json['late'] as bool,
      stillMember: json['stillMember'] as bool,
    );
  }
}
