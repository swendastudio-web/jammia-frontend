import 'package:flutter/material.dart';

/// A full-width button that shows a spinner and is disabled while [loading].
class LoadingButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onPressed;
  final bool outlined;

  const LoadingButton({
    super.key,
    required this.label,
    required this.loading,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
        : Text(label);
    final action = loading ? null : onPressed;
    return outlined
        ? OutlinedButton(onPressed: action, child: child)
        : FilledButton(onPressed: action, child: child);
  }
}
