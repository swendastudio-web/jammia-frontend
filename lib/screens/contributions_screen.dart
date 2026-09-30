import 'package:flutter/material.dart';

import '../utils/error_text.dart';
import '../l10n/app_localizations.dart';
import '../models/contribution.dart';
import '../models/room.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../utils/format.dart';
import '../widgets/empty_state.dart';
import '../widgets/load_error_view.dart';
import '../widgets/status_chip.dart';
import '../theme/app_theme.dart';

/// The payment schedule of a started room, cycle by cycle.
/// The payer taps "I paid"; the recipient taps "I received it".
class ContributionsScreen extends StatefulWidget {
  final AppServices services;
  final Room room;

  const ContributionsScreen({super.key, required this.services, required this.room});

  @override
  State<ContributionsScreen> createState() => _ContributionsScreenState();
}

class _ContributionsScreenState extends State<ContributionsScreen> {
  List<Contribution>? _items;
  String? _error;
  bool _loading = true;
  final Set<int> _busy = {};

  int get _myId => widget.services.session.user!.id;

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
      final items = await widget.services.contributions.getContributions(widget.room.id);
      if (mounted) setState(() => _items = items);
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = errorText(AppLocalizations.of(context), e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _act(Contribution c, {required bool confirm}) async {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (confirm) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(t.confirmReceivedTitle),
          content: Text(t.confirmReceivedMessage(formatMoney(c.amount, widget.room.currency, locale), c.payer.fullName)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text(t.cancel)),
            TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: Text(t.yesReceived)),
          ],
        ),
      );
      if (ok != true) return;
    }

    setState(() => _busy.add(c.id));
    try {
      if (confirm) {
        await widget.services.contributions.confirmReceived(widget.room.id, c.id);
      } else {
        await widget.services.contributions.markPaid(widget.room.id, c.id);
      }
      await _load();
    } on ApiException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorText(t, e))));
    } finally {
      if (mounted) setState(() => _busy.remove(c.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).payments)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final t = AppLocalizations.of(context);
    if (_loading && _items == null) return const Center(child: CircularProgressIndicator());
    if (_error != null && _items == null) return LoadErrorView(message: _error!, onRetry: _load);
    final items = _items ?? [];
    if (items.isEmpty) {
      return EmptyState(
        icon: Icons.receipt_long_outlined,
        title: t.noPaymentsTitle,
        message: t.noPaymentsMessage,
      );
    }

    // Group by cycle: {1: [...], 2: [...]}
    final cycles = <int, List<Contribution>>{};
    for (final c in items) {
      cycles.putIfAbsent(c.cycleNumber, () => []).add(c);
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(t.noMoneyNote, style: const TextStyle(color: AppTheme.darkGray)),
          const SizedBox(height: 16),
          for (final entry in cycles.entries) _buildCycle(entry.key, entry.value),
        ],
      ),
    );
  }

  Widget _buildCycle(int cycle, List<Contribution> list) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final recipient = list.first.recipient;
    final confirmed = list.where((c) => c.status == 'CONFIRMED').length;
    final total = formatMoney(list.first.amount * (list.length + 1), widget.room.currency, locale);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(t.cycleHeader(cycle, formatDate(list.first.dueDate, locale)),
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                StatusChip(t.receivedCount(confirmed, list.length), dark: confirmed == list.length),
              ],
            ),
            const SizedBox(height: 2),
            // Total = what the others pay + the receiver's own share (like the master prompt's example).
            Text(recipient.userId == _myId
                ? t.youReceiveTotal(total)
                : t.personReceivesTotal(recipient.fullName, total)),
            const Divider(height: 20),
            ...list.map(_buildRow),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(Contribution c) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final iAmPayer = c.payer.userId == _myId;
    final iAmRecipient = c.recipient.userId == _myId;
    final busy = _busy.contains(c.id);

    Widget? action;
    if (iAmPayer && c.status == 'PENDING') {
      action = TextButton(onPressed: busy ? null : () => _act(c, confirm: false), child: Text(t.iPaid));
    } else if (iAmRecipient && c.status != 'CONFIRMED') {
      action = TextButton(
          onPressed: busy ? null : () => _act(c, confirm: true), child: Text(t.iReceivedIt));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(iAmPayer ? t.youPay : t.personPays(c.payer.fullName),
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(formatMoney(c.amount, widget.room.currency, locale), style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          StatusChip(contributionStatusLabel(t, c.status), dark: c.status == 'CONFIRMED'),
          if (action != null) ...[const SizedBox(width: 4), action],
        ],
      ),
    );
  }
}
