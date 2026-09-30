import 'package:flutter/material.dart';
import '../utils/error_text.dart';
import '../l10n/app_localizations.dart';
import 'package:flutter/services.dart';

import '../models/invitation.dart';
import '../models/room.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../utils/format.dart';
import '../widgets/error_banner.dart';
import '../widgets/info_row.dart';
import '../widgets/load_error_view.dart';
import '../widgets/member_avatar.dart';
import '../widgets/status_chip.dart';
import 'contributions_screen.dart';
import 'start_room_screen.dart';

/// One room: details, members, invite link, join requests (creator), start (creator), payments.
class RoomDetailsScreen extends StatefulWidget {
  final AppServices services;
  final int roomId;

  const RoomDetailsScreen({super.key, required this.services, required this.roomId});

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  Room? _room;
  List<JoinRequest> _requests = [];
  String? _error;
  bool _loading = true;
  final Set<int> _busyRequests = {};

  int get _myId => widget.services.session.user!.id;
  bool get _iAmCreator => _room?.creatorUserId == _myId;

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
      final room = await widget.services.rooms.getRoom(widget.roomId);
      var requests = <JoinRequest>[];
      if (room.isOpen && room.creatorUserId == _myId) {
        requests = await widget.services.invitations.getPendingRequests(room.id);
      }
      if (mounted) {
        setState(() {
          _room = room;
          _requests = requests;
        });
      }
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = errorText(AppLocalizations.of(context), e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _showInviteLink() async {
    try {
      final link = await widget.services.invitations.getMyInviteLink(widget.roomId);
      if (!mounted) return;
      await showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (sheetContext) => _InviteLinkSheet(
          link: link,
          onCopy: () async {
            await Clipboard.setData(ClipboardData(text: link.url));
            if (sheetContext.mounted) Navigator.of(sheetContext).pop();
            if (mounted) _showMessage(AppLocalizations.of(context).linkCopied);
          },
        ),
      );
    } on ApiException catch (e) {
      if (mounted) _showMessage(errorText(AppLocalizations.of(context), e));
    }
  }

  Future<void> _decide(JoinRequest request, {required bool approve}) async {
    final t = AppLocalizations.of(context);
    setState(() => _busyRequests.add(request.id));
    try {
      if (approve) {
        await widget.services.invitations.approve(widget.roomId, request.id);
        _showMessage(t.nowMember(request.requesterName));
      } else {
        await widget.services.invitations.reject(widget.roomId, request.id);
        _showMessage(t.requestRejected(request.requesterName));
      }
      await _load();
    } on ApiException catch (e) {
      _showMessage(errorText(t, e));
    } finally {
      if (mounted) setState(() => _busyRequests.remove(request.id));
    }
  }

  Future<void> _openStart() async {
    final started = await Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (_) => StartRoomScreen(services: widget.services, room: _room!),
    ));
    if (started == true) _load();
  }

  void _openPayments() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ContributionsScreen(services: widget.services, room: _room!),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_room?.name ?? AppLocalizations.of(context).room)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading && _room == null) return const Center(child: CircularProgressIndicator());
    if (_error != null && _room == null) return LoadErrorView(message: _error!, onRetry: _load);
    final room = _room!;
    final t = AppLocalizations.of(context);

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_error != null) ...[ErrorBanner(_error!), const SizedBox(height: 12)],
          _buildSummary(room),
          const SizedBox(height: 16),
          ..._buildActions(room),
          if (_iAmCreator && room.isOpen) ..._buildRequests(),
          const SizedBox(height: 16),
          Text(t.membersTitle(room.members.length, room.maxMembers),
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...room.members.map((m) => _buildMember(room, m)),
        ],
      ),
    );
  }

  Widget _buildSummary(Room room) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(formatMoney(room.contributionAmount, room.currency, locale),
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                StatusChip(roomStatusLabel(t, room.status), dark: room.status == 'ACTIVE'),
              ],
            ),
            Text(t.perPersonEachCycle),
            if (room.description != null) ...[const SizedBox(height: 8), Text(room.description!)],
            const SizedBox(height: 12),
            InfoRow(t.howOften, frequencyLabel(t, room.frequency)),
            // Like the master prompt: 10 members x 1,000 = 10,000 each cycle (the receiver's own share included).
            InfoRow(
              t.totalEachCycle,
              room.isOpen
                  ? t.totalUpTo(formatMoney(room.contributionAmount * room.maxMembers, room.currency, locale),
                      room.maxMembers)
                  : formatMoney(room.contributionAmount * room.members.length, room.currency, locale),
            ),
            if (room.startDate != null) InfoRow(t.firstDueDate, formatDate(room.startDate!, locale)),
            if (room.turnOrderMethod != null)
              InfoRow(t.turnOrder, room.turnOrderMethod == 'RANDOM' ? t.turnOrderRandom : t.turnOrderManual),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions(Room room) {
    final t = AppLocalizations.of(context);
    if (room.isOpen) {
      return [
        FilledButton.icon(
          key: const Key('invite-button'),
          onPressed: _showInviteLink,
          icon: const Icon(Icons.person_add_alt),
          label: Text(t.invitePeople),
        ),
        if (_iAmCreator) ...[
          const SizedBox(height: 8),
          OutlinedButton.icon(
            key: const Key('start-button'),
            onPressed: room.members.length >= 2 ? _openStart : null,
            icon: const Icon(Icons.play_arrow),
            label: Text(room.members.length >= 2 ? t.startRoom : t.startRoomNeedsMembers),
          ),
        ],
      ];
    }
    return [
      FilledButton.icon(
        key: const Key('payments-button'),
        onPressed: _openPayments,
        icon: const Icon(Icons.receipt_long),
        label: Text(t.payments),
      ),
    ];
  }

  List<Widget> _buildRequests() {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return [
      const SizedBox(height: 24),
      Text(t.joinRequestsTitle(_requests.length), style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      if (_requests.isEmpty) Text(t.noJoinRequests),
      ..._requests.map((r) {
        final busy = _busyRequests.contains(r.id);
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.requesterName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 2),
                Text(t.referredByName(r.referredByName)),
                Text(t.askedAt(formatDateTime(r.createdAt, locale)), style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: busy ? null : () => _decide(r, approve: false),
                        child: Text(t.reject),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed: busy ? null : () => _decide(r, approve: true),
                        child: Text(t.accept),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    ];
  }

  Widget _buildMember(Room room, RoomMember m) {
    final t = AppLocalizations.of(context);
    final isMe = m.userId == _myId;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: MemberAvatar(firstName: m.firstName, lastName: m.lastName),
      title: Text(isMe ? t.nameYou(m.fullName) : m.fullName),
      subtitle: Text(m.turnPosition == null ? t.turnDecidedLater : t.turnInfo(m.turnPosition!)),
      trailing: m.userId == room.creatorUserId ? StatusChip(t.creator) : null,
    );
  }
}

class _InviteLinkSheet extends StatelessWidget {
  final InviteLink link;
  final VoidCallback onCopy;

  const _InviteLinkSheet({required this.link, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(t.yourInviteLink, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(t.inviteLinkExplanation),
            const SizedBox(height: 12),
            SelectableText(link.url, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(t.worksUntil(formatDateTime(link.expiresAt, locale)), style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 16),
            FilledButton.icon(onPressed: onCopy, icon: const Icon(Icons.copy), label: Text(t.copyLink)),
          ],
        ),
      ),
    );
  }
}
