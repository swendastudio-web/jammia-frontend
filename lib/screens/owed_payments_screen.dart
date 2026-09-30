import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/owed_payment.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../utils/error_text.dart';
import '../utils/format.dart';
import '../widgets/empty_state.dart';
import '../widgets/load_error_view.dart';
import '../widgets/status_chip.dart';

/// "What you owe": every payment whose turn has started and that you have not marked as paid,
/// in every room — also rooms you were removed from. Tap "I paid" when you have paid.
class OwedPaymentsScreen extends StatefulWidget {
  final AppServices services;

  const OwedPaymentsScreen({super.key, required this.services});

  @override
  State<OwedPaymentsScreen> createState() => _OwedPaymentsScreenState();
}

class _OwedPaymentsScreenState extends State<OwedPaymentsScreen> {
  List<OwedPayment>? _items;
  String? _error;
  bool _loading = true;
  final Set<int> _busy = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final items = await widget.services.contributions.getOwedPayments();
      if (mounted) setState(() => _items = items);
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = errorText(AppLocalizations.of(context), e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _markPaid(OwedPayment p) async {
    final t = AppLocalizations.of(context);
    setState(() => _busy.add(p.contributionId));
    try {
      await widget.services.contributions.markPaid(p.roomId, p.contributionId);
      await _load();
    } on ApiException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorText(t, e))));
    } finally {
      if (mounted) setState(() => _busy.remove(p.contributionId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.owedPaymentsTitle)),
      body: _buildBody(t),
    );
  }

  Widget _buildBody(AppLocalizations t) {
    if (_loading && _items == null) return const Center(child: CircularProgressIndicator());
    if (_error != null && _items == null) return LoadErrorView(message: _error!, onRetry: _load);
    final items = _items ?? [];
    if (items.isEmpty) {
      return EmptyState(icon: Icons.check_circle_outline, title: t.owedPaymentsTitle, message: t.nothingOwed);
    }
    final locale = Localizations.localeOf(context).toLanguageTag();
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) {
          final p = items[i];
          final busy = _busy.contains(p.contributionId);
          return Card(
            key: Key('owed-${p.contributionId}'),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(p.roomName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      ),
                      if (p.late) StatusChip(t.late, dark: true),
                    ],
                  ),
                  Text(t.owedRoundTurn(p.roundNumber, p.cycleNumber)),
                  Text(t.owedTo(p.recipientName)),
                  if (!p.stillMember) ...[
                    const SizedBox(height: 4),
                    Text(t.removedFromRoomNote, style: const TextStyle(fontSize: 12)),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(formatMoney(p.amount, p.currency, locale),
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      TextButton(
                        onPressed: busy ? null : () => _markPaid(p),
                        child: Text(t.iPaid),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
