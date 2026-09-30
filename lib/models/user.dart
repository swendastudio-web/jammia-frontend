/// The signed-in user's own account (matches UserResponse in the backend).
class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String subscriptionPlan;
  final String role;
  final String preferredLanguage;
  final bool hasProfilePhoto;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.subscriptionPlan,
    required this.role,
    required this.preferredLanguage,
    required this.hasProfilePhoto,
  });

  String get fullName => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      subscriptionPlan: json['subscriptionPlan'] as String,
      role: json['role'] as String,
      preferredLanguage: (json['preferredLanguage'] as String?) ?? 'en',
      hasProfilePhoto: json['hasProfilePhoto'] as bool,
    );
  }
}
