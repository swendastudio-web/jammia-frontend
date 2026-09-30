/// A subscription plan and its biggest allowed room (matches SubscriptionPlanResponse).
class SubscriptionPlan {
  final String code;
  final int maxMembersPerRoom;

  const SubscriptionPlan({required this.code, required this.maxMembersPerRoom});

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlan(
      code: json['code'] as String,
      maxMembersPerRoom: json['maxMembersPerRoom'] as int,
    );
  }
}
