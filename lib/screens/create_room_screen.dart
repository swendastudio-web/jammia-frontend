import 'package:flutter/material.dart';

import '../utils/format.dart';
import '../utils/error_text.dart';
import '../l10n/app_localizations.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../utils/validators.dart';
import '../widgets/error_banner.dart';
import '../widgets/loading_button.dart';

/// Create a savings room. The biggest allowed size comes from the user's plan (from the backend).
/// Returns the new room's id to the previous screen.
class CreateRoomScreen extends StatefulWidget {
  final AppServices services;

  const CreateRoomScreen({super.key, required this.services});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  List<String> _frequencies = const ['WEEKLY', 'BIWEEKLY', 'MONTHLY'];

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _amount = TextEditingController();
  final _currency = TextEditingController();
  final _maxMembers = TextEditingController();
  String _frequency = 'MONTHLY';
  int? _planLimit;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPlanLimit();
    _loadTestPeriod();
  }

  // A development backend also offers "Every 5 minutes (test)"; production never does.
  Future<void> _loadTestPeriod() async {
    try {
      if (await widget.services.rooms.fiveMinuteCyclesEnabled() && mounted) {
        setState(() => _frequencies = const ['FIVE_MINUTES', 'WEEKLY', 'BIWEEKLY', 'MONTHLY']);
      }
    } on ApiException {
      // Not critical: without it, only the normal periods are offered.
    }
  }

  // Shows "Your FREE plan allows up to 5 members" under the field.
  Future<void> _loadPlanLimit() async {
    final planCode = widget.services.session.user?.subscriptionPlan;
    try {
      final plans = await widget.services.users.getPlans();
      final plan = plans.where((p) => p.code == planCode).firstOrNull;
      if (mounted && plan != null) setState(() => _planLimit = plan.maxMembersPerRoom);
    } on ApiException {
      // Not critical: the backend still checks the limit when the room is created.
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _amount.dispose();
    _currency.dispose();
    _maxMembers.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final room = await widget.services.rooms.createRoom(
        name: _name.text.trim(),
        description: _description.text.trim().isEmpty ? null : _description.text.trim(),
        contributionAmount: num.parse(_amount.text.trim()),
        currency: _currency.text.trim().toUpperCase(),
        frequency: _frequency,
        maxMembers: int.parse(_maxMembers.text.trim()),
      );
      // Go back to "My rooms" with the new room's id; it opens the room (and refreshes when you come back).
      if (mounted) Navigator.of(context).pop(room.id);
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = errorText(AppLocalizations.of(context), e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String? _amountValidator(AppLocalizations t, String? v) {
    final required = requiredText(v, t.amountRequired);
    if (required != null) return required;
    final text = v!.trim();
    final value = num.tryParse(text);
    if (value == null || value <= 0) return t.amountAboveZero;
    if (text.contains('.') && text.split('.')[1].length > 2) return t.amountDecimals;
    return null;
  }

  String? _maxMembersValidator(AppLocalizations t, String? v) {
    final value = int.tryParse(v?.trim() ?? '');
    if (value == null) return t.enterNumber;
    if (value < 2) return t.minTwoMembers;
    if (_planLimit != null && value > _planLimit!) return t.planAllowsUpTo(_planLimit!);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final plan = widget.services.session.user?.subscriptionPlan ?? '';
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.newRoom)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_error != null) ...[ErrorBanner(_error!), const SizedBox(height: 16)],
                TextFormField(
                  key: const Key('room-name'),
                  controller: _name,
                  decoration: InputDecoration(labelText: t.roomName),
                  maxLength: 100,
                  validator: (v) => requiredText(v, t.nameRequired),
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _description,
                  decoration: InputDecoration(labelText: t.descriptionOptional),
                  maxLength: 500,
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        key: const Key('room-amount'),
                        controller: _amount,
                        decoration: InputDecoration(labelText: t.amountPerPerson),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (v) => _amountValidator(t, v),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        key: const Key('room-currency'),
                        controller: _currency,
                        decoration: InputDecoration(labelText: t.currency, hintText: 'OMR'),
                        textCapitalization: TextCapitalization.characters,
                        maxLength: 3,
                        validator: (v) => RegExp(r'^[A-Za-z]{3}$').hasMatch(v?.trim() ?? '')
                            ? null
                            : t.currencyLetters,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  initialValue: _frequency,
                  decoration: InputDecoration(labelText: t.howOften),
                  items: _frequencies
                      .map((f) => DropdownMenuItem(value: f, child: Text(frequencyLabel(t, f))))
                      .toList(),
                  onChanged: (v) => setState(() => _frequency = v!),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('room-max-members'),
                  controller: _maxMembers,
                  decoration: InputDecoration(
                    labelText: t.maximumMembers,
                    helperText: _planLimit == null ? null : t.planAllowsHelper(plan, _planLimit!),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (v) => _maxMembersValidator(t, v),
                ),
                const SizedBox(height: 24),
                LoadingButton(label: t.createRoom, loading: _loading, onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
