import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A small gray label, e.g. "Open", "Paid", "Creator".
class StatusChip extends StatelessWidget {
  final String label;
  final bool dark;

  const StatusChip(this.label, {super.key, this.dark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: dark ? AppTheme.darkGray : AppTheme.lightGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 12, color: dark ? AppTheme.white : AppTheme.black),
      ),
    );
  }
}
