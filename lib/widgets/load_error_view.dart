import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'error_banner.dart';

/// Shown when a screen could not load its data, with a "Try again" button.
class LoadErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const LoadErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ErrorBanner(message),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onRetry, child: Text(AppLocalizations.of(context).tryAgain)),
          ],
        ),
      ),
    );
  }
}
