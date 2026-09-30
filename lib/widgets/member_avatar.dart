import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A gray circle with a person's initials (photos come in a later step).
class MemberAvatar extends StatelessWidget {
  final String firstName;
  final String lastName;
  final double radius;

  const MemberAvatar({super.key, required this.firstName, required this.lastName, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    final initials = '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}';
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppTheme.lightGray,
      foregroundColor: AppTheme.black,
      child: Text(initials.toUpperCase(), style: TextStyle(fontSize: radius * 0.7)),
    );
  }
}
