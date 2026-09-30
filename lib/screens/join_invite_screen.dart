import 'package:flutter/material.dart';

import '../utils/error_text.dart';
import '../l10n/app_localizations.dart';
import '../models/invitation.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../services/invitation_service.dart';
import '../utils/format.dart';
import '../widgets/error_banner.dart';
import '../widgets/info_row.dart';
import '../widgets/loading_button.dart';

/// Paste an invite link from a friend, see what the room is and who referred you, then ask to join.
/// (Later, tapping the link on the phone will open this screen directly.)
class JoinInviteScreen extends StatefulWidget {
  final AppServices services;

  const JoinInviteScreen({super.key, required this.services});

  @override
  State<JoinInviteScreen> createState() => _JoinInviteScreenState();
}

class _JoinInviteScreenState extends State<JoinInviteScreen> {
  final _link = TextEditingController();
  String? _token;
  InvitePreview? _preview;
  bool _loading = false;
  bool _requestSent = false;
  String? _error;

  @override
  void dispose() {
    _link.dispose();
    super.dispose();
  }

  Future<void> _loadPreview() async {
    final token = InvitationService.extractToken(_link.text);
    if (token.isEmpty) {
      setState(() => _error = AppLocalizations.of(context).pasteInviteLink);
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
      _preview = null;
      _requestSent = false;
    });
    try {
      final preview = await widget.services.invitations.preview(token);
      if (mounted) {
        setState(() {
          _token = token;
          _preview = preview;
        });
      }
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = errorText(AppLocalizations.of(context), e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _requestToJoin() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await widget.services.invitations.requestToJoin(_token!);
      if (mounted) setState(() => _requestSent = true);
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
      appBar: AppBar(title: Text(t.joinWithInviteLink)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                key: const Key('invite-link'),
                controller: _link,
                decoration: InputDecoration(
                  labelText: t.inviteLink,
                  hintText: 'https://jamia.app/invite/...',
                ),
                autocorrect: false,
                onSubmitted: (_) => _loadPreview(),
              ),
              const SizedBox(height: 12),
              LoadingButton(
                label: t.showRoom,
                loading: _loading && _preview == null,
                onPressed: _loadPreview,
                outlined: _preview != null,
              ),
              if (_error != null) ...[const SizedBox(height: 16), ErrorBanner(_error!)],
              if (_preview != null) ...[const SizedBox(height: 24), _buildPreview(_preview!)],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreview(InvitePreview p) {
    final t = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final Widget action;
    if (p.alreadyMember) {
      action = Text(t.alreadyMember, textAlign: TextAlign.center);
    } else if (_requestSent || p.requestPending) {
      action = Text(
        t.requestSent,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w600),
      );
    } else {
      action = LoadingButton(label: t.requestToJoin, loading: _loading, onPressed: _requestToJoin);
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(p.roomName, style: Theme.of(context).textTheme.titleLarge),
            if (p.roomDescription != null) ...[const SizedBox(height: 4), Text(p.roomDescription!)],
            const SizedBox(height: 12),
            InfoRow(t.referredBy, p.referredByName),
            InfoRow(t.createdBy, p.creatorName),
            InfoRow(t.amount, t.amountPerPersonValue(formatMoney(p.contributionAmount, p.currency, locale))),
            InfoRow(t.howOften, frequencyLabel(t, p.frequency)),
            InfoRow(t.members, t.countOfMax(p.memberCount, p.maxMembers)),
            const SizedBox(height: 16),
            action,
          ],
        ),
      ),
    );
  }
}
