import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/contribution.dart';
import '../models/room.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../theme/app_theme.dart';
import '../utils/error_text.dart';
import '../utils/format.dart';
import '../widgets/empty_state.dart';
import '../widgets/load_error_view.dart';
import '../widgets/status_chip.dart';

/// The payments of one round, turn by turn (default: the newest round).
/// The payer taps "I paid"; the receiver taps "I received it".
/// The turn moves by the clock: the current turn is marked "Now", unpaid past turns "Late".
class ContributionsScreen extends StatefulWidget {
  final AppServices services;
  final Room room;
  final int? roundNumber; // null = newest round

  const ContributionsScreen({super.key, required this.services, required this.room, this.roundNumber});

  @override
  State<ContributionsScreen> createState() => _ContributionsScreenState();
}

class _ContributionsScreenState extends State<ContributionsScreen> {
  List<Contribution>? _items;
  String? _error;
  bool _loading = true;
  final Set<int> _busy = {};
  Timer? _refreshTimer;

  int get _myId => widget.services.session.user!.id;

  @override
  void initState() {
    super.initState();
    _load();
    // Watching the running round: refresh every 15 seconds so "Now" and "Late" stay correct.
    if (widget.roundNumber == null) {
      _refreshTimer = Timer.periodic(const Duration(seconds: 15), (_) => _load(quiet: true));
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _load({bool quiet = false}) async {
    if (!quiet) {
      setState(() {
        _loading = true;
        _error = null;
      });
    }
    try {
      final items = await widget.services.contributions
          .getContributions(widget.room.id, roundNumber: widget.roundNumber);
      if (mounted) setState(() => _items = items);
    } on ApiException catch (e) {
      if (mounted && !quiet) setState(() => _error = errorText(AppLocalizations.of(context), e));
    } finally {
      if (mounted && !quiet) setState(() => _loading = false);
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
    final t = AppLocalizations.of(context);
    final round = widget.roundNumber ?? _items?.firstOrNull?.roundNumber;
    return Scaffold(
      appBar: AppBar(title: Text(round == null ? t.payments : '${t.payments} · ${t.roundTitle(round)}')),
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

    // Group by turn: {1: [...], 2: [...]}
    final turns = <int, List<Contribution>>{};
    for (final c in items) {
      turns.putIfAbsent(c.cycleNumber, () => []).add(c);
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(t.noMoneyNote, style: const TextStyle(color: AppTheme.darkGray)),
          const SizedBox(height: 16),
          for (final entry in turns.entries) _buildTurn(entry.key, entry.value),
        ],
      ),
    );
  }

  Widget _buildTurn(int turn, List<Contribution> list) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final first = list.first;
    final recipient = first.recipient;
    final confirmed = list.where((c) => c.status == 'CONFIRMED').length;
    final total = formatMoney(first.amount * (list.length + 1), widget.room.currency, locale);
    final now = DateTime.now();
    final isNow = !now.isBefore(first.dueAt) && now.isBefore(first.turnEndsAt);
    final when = widget.room.isFiveMinuteTest ? formatDateTime(first.dueAt, locale) : formatDate(first.dueAt, locale);

    return Card(
      key: Key('turn-$turn'),
      color: isNow ? AppTheme.lightGray : null,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(t.cycleHeader(turn, when), style: Theme.of(context).textTheme.titleMedium)),
                if (isNow) ...[StatusChip(t.nowLabel, dark: true), const SizedBox(width: 4)],
                StatusChip(t.receivedCount(confirmed, list.length), dark: confirmed == list.length),
              ],
            ),
            const SizedBox(height: 2),
            // Total = what the others pay + the receiver's own share (like the master prompt's example).
            Text(recipient.userId == _myId ? t.youReceiveTotal(total) : t.personReceivesTotal(recipient.fullName, total)),
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
      action = TextButton(onPressed: busy ? null : () => _act(c, confirm: true), child: Text(t.iReceivedIt));
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
          if (c.late) ...[StatusChip(t.late, dark: true), const SizedBox(width: 4)],
          StatusChip(contributionStatusLabel(t, c.status), dark: c.status == 'CONFIRMED'),
          if (action != null) ...[const SizedBox(width: 4), action],
        ],
      ),
    );
  }
}
