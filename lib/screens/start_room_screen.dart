import 'package:flutter/material.dart';

import '../utils/error_text.dart';
import '../l10n/app_localizations.dart';
import '../models/room.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../utils/format.dart';
import '../widgets/error_banner.dart';
import '../widgets/loading_button.dart';
import '../widgets/member_avatar.dart';

/// The creator starts the room: random or manual turn order, and the first due date.
/// Returns true to the previous screen when the room has started.
class StartRoomScreen extends StatefulWidget {
  final AppServices services;
  final Room room;

  const StartRoomScreen({super.key, required this.services, required this.room});

  @override
  State<StartRoomScreen> createState() => _StartRoomScreenState();
}

class _StartRoomScreenState extends State<StartRoomScreen> {
  String _method = 'RANDOM';
  DateTime _startDate = DateUtils.dateOnly(DateTime.now());
  late final List<RoomMember> _order = List.of(widget.room.members);
  bool _loading = false;
  String? _error;

  Future<void> _pickDate() async {
    final today = DateUtils.dateOnly(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _start() async {
    final t = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(t.startRoomConfirmTitle),
        content: Text(t.startRoomConfirmMessage),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: Text(t.cancel)),
          TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: Text(t.start)),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await widget.services.rooms.startRoom(
        roomId: widget.room.id,
        turnOrderMethod: _method,
        startDate: widget.room.isFiveMinuteTest ? null : _startDate,
        memberOrder: _method == 'MANUAL' ? _order.map((m) => m.userId).toList() : null,
      );
      if (mounted) Navigator.of(context).pop(true);
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = errorText(AppLocalizations.of(context), e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Scaffold(
      appBar: AppBar(title: Text(t.startRoom)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (_error != null) ...[ErrorBanner(_error!), const SizedBox(height: 12)],
                  Text(t.turnOrder, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  SegmentedButton<String>(
                    segments: [
                      ButtonSegment(value: 'RANDOM', label: Text(t.randomOption), icon: const Icon(Icons.shuffle)),
                      ButtonSegment(
                          value: 'MANUAL', label: Text(t.iChoose), icon: const Icon(Icons.format_list_numbered)),
                    ],
                    selected: {_method},
                    onSelectionChanged: (s) => setState(() => _method = s.first),
                  ),
                  const SizedBox(height: 8),
                  Text(_method == 'RANDOM' ? t.randomExplanation : t.manualExplanation),
                  const SizedBox(height: 24),
                  Text(t.firstDueDate, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  if (widget.room.isFiveMinuteTest)
                    Text(t.fiveMinuteStartsNow, key: const Key('five-minute-note'))
                  else
                    OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(formatDate(_startDate, locale)),
                    ),
                  if (_method == 'MANUAL') ...[
                    const SizedBox(height: 24),
                    Text(t.order, style: Theme.of(context).textTheme.titleMedium),
                    ReorderableListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      buildDefaultDragHandles: true,
                      onReorder: (oldIndex, newIndex) => setState(() {
                        if (newIndex > oldIndex) newIndex -= 1;
                        _order.insert(newIndex, _order.removeAt(oldIndex));
                      }),
                      children: [
                        for (var i = 0; i < _order.length; i++)
                          ListTile(
                            key: ValueKey(_order[i].userId),
                            leading: MemberAvatar(firstName: _order[i].firstName, lastName: _order[i].lastName),
                            title: Text(_order[i].fullName),
                            subtitle: Text(t.turnNumber(i + 1)),
                            trailing: const Icon(Icons.drag_handle),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: LoadingButton(
                label: widget.room.completedRounds == 0 ? t.startRoom : t.startRoundNumber(widget.room.completedRounds + 1),
                loading: _loading,
                onPressed: _start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
