import 'package:flutter/material.dart';

import '../utils/error_text.dart';
import '../l10n/app_localizations.dart';
import '../models/owed_payment.dart';
import '../models/room.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/empty_state.dart';
import '../widgets/load_error_view.dart';
import '../widgets/status_chip.dart';
import 'create_room_screen.dart';
import 'join_invite_screen.dart';
import 'owed_payments_screen.dart';
import 'profile_screen.dart';
import 'room_details_screen.dart';

/// Home screen after login: the rooms you belong to.
class RoomsScreen extends StatefulWidget {
  final AppServices services;

  const RoomsScreen({super.key, required this.services});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  List<RoomSummary>? _rooms;
  List<OwedPayment> _owed = [];
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
      final rooms = await widget.services.rooms.getMyRooms();
      if (mounted) setState(() => _rooms = rooms);
      _loadOwed();
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = errorText(AppLocalizations.of(context), e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // The "You owe" reminder. Not critical: if it can't load, the rooms still show.
  Future<void> _loadOwed() async {
    try {
      final owed = await widget.services.contributions.getOwedPayments();
      if (mounted) setState(() => _owed = owed);
    } on ApiException {
      // ignore
    }
  }

  Future<void> _open(Widget screen) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
    if (mounted) _load(); // something may have changed (new room, joined, started...)
  }

  // After creating a room, open it right away. The list refreshes when you come back.
  Future<void> _createRoom() async {
    final roomId = await Navigator.of(context).push<int>(
      MaterialPageRoute(builder: (_) => CreateRoomScreen(services: widget.services)),
    );
    if (!mounted) return;
    if (roomId == null) {
      _load();
      return;
    }
    await _open(RoomDetailsScreen(services: widget.services, roomId: roomId));
  }

  @override
  Widget build(BuildContext context) {
    final services = widget.services;
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.myRooms),
        actions: [
          IconButton(
            tooltip: t.joinWithInviteLink,
            icon: const Icon(Icons.link),
            onPressed: () => _open(JoinInviteScreen(services: services)),
          ),
          IconButton(
            tooltip: t.profile,
            icon: const Icon(Icons.person_outline),
            onPressed: () => _open(ProfileScreen(services: services)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createRoom,
        icon: const Icon(Icons.add),
        label: Text(t.newRoom),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading && _rooms == null) return const Center(child: CircularProgressIndicator());
    if (_error != null && _rooms == null) return LoadErrorView(message: _error!, onRetry: _load);
    return Column(
      children: [
        if (_owed.isNotEmpty) _buildOwedBanner(),
        Expanded(child: _buildRooms()),
      ],
    );
  }

  // "You owe 20.00 OMR (2 payments)" — totals per currency. Tap to see and pay.
  Widget _buildOwedBanner() {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final totals = <String, num>{};
    for (final p in _owed) {
      totals[p.currency] = (totals[p.currency] ?? 0) + p.amount;
    }
    final amounts = totals.entries.map((e) => formatMoney(e.value, e.key, locale)).join(' + ');
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Material(
        color: AppTheme.darkGray,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          key: const Key('owed-banner'),
          borderRadius: BorderRadius.circular(12),
          onTap: () => _open(OwedPaymentsScreen(services: widget.services)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.notifications_active_outlined, color: AppTheme.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.owedBannerTitle(amounts, _owed.length),
                          style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.w600)),
                      Text(t.owedBannerAction, style: const TextStyle(color: AppTheme.white, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppTheme.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRooms() {
    final t = AppLocalizations.of(context);
    final rooms = _rooms ?? [];
    if (rooms.isEmpty) {
      return EmptyState(
        icon: Icons.groups_outlined,
        title: t.noRoomsTitle,
        message: t.noRoomsMessage,
        action: OutlinedButton.icon(
          onPressed: () => _open(JoinInviteScreen(services: widget.services)),
          icon: const Icon(Icons.link),
          label: Text(t.joinWithInviteLink),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        itemCount: rooms.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) => _RoomCard(
          room: rooms[i],
          onTap: () => _open(RoomDetailsScreen(services: widget.services, roomId: rooms[i].id)),
        ),
      ),
    );
  }
}

class _RoomCard extends StatelessWidget {
  final RoomSummary room;
  final VoidCallback onTap;

  const _RoomCard({required this.room, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Card(
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(room.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(t.roomCardSubtitle(formatMoney(room.contributionAmount, room.currency, locale),
              frequencyLabel(t, room.frequency), room.maxMembers)),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            StatusChip(roomStatusLabel(t, room.status), dark: room.status == 'ACTIVE'),
            if (room.createdByMe) ...[const SizedBox(height: 4), Text(t.creator, style: const TextStyle(fontSize: 12))],
          ],
        ),
      ),
    );
  }
}
