import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/room.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../utils/error_text.dart';
import '../utils/format.dart';
import '../widgets/empty_state.dart';
import '../widgets/load_error_view.dart';
import '../widgets/status_chip.dart';
import 'contributions_screen.dart';

/// The rounds of a room, newest first. Tap a round to see its payments.
class RoundsScreen extends StatefulWidget {
  final AppServices services;
  final Room room;

  const RoundsScreen({super.key, required this.services, required this.room});

  @override
  State<RoundsScreen> createState() => _RoundsScreenState();
}

class _RoundsScreenState extends State<RoundsScreen> {
  List<RoomRound>? _rounds;
  String? _error;
  bool _loading = true;

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
      final rounds = await widget.services.rooms.getRounds(widget.room.id);
      if (mounted) setState(() => _rounds = rounds);
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = errorText(AppLocalizations.of(context), e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.roundsHistory)),
      body: _buildBody(t),
    );
  }

  Widget _buildBody(AppLocalizations t) {
    if (_loading && _rounds == null) return const Center(child: CircularProgressIndicator());
    if (_error != null && _rounds == null) return LoadErrorView(message: _error!, onRetry: _load);
    final rounds = _rounds ?? [];
    if (rounds.isEmpty) {
      return EmptyState(icon: Icons.history, title: t.roundsHistory, message: t.noRoundsYet);
    }
    final locale = Localizations.localeOf(context).toLanguageTag();
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: rounds.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) {
          final r = rounds[i];
          return Card(
            child: ListTile(
              key: Key('round-${r.roundNumber}'),
              title: Text(t.roundTitle(r.roundNumber), style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${t.roundDates(formatDateTime(r.startedAt, locale), formatDateTime(r.endsAt, locale))}\n'
                  '${t.receivedCount(r.paymentsReceived, r.paymentsTotal)}'),
              isThreeLine: true,
              trailing: StatusChip(r.isRunning ? t.roundStatusActive : t.roundStatusCompleted, dark: r.isRunning),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ContributionsScreen(
                  services: widget.services,
                  room: widget.room,
                  roundNumber: r.roundNumber,
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
