import 'package:flutter/material.dart';

import '../widgets/language_picker.dart';
import '../utils/error_text.dart';
import '../l10n/app_localizations.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../utils/validators.dart';
import '../widgets/error_banner.dart';
import '../widgets/info_row.dart';
import '../widgets/loading_button.dart';
import '../widgets/member_avatar.dart';
import 'change_password_screen.dart';

/// Your account: edit name and phone, change password, log out.
/// (Profile photo comes later; it needs an image-picker library.)
class ProfileScreen extends StatefulWidget {
  final AppServices services;

  const ProfileScreen({super.key, required this.services});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _firstName = TextEditingController(text: widget.services.session.user!.firstName);
  late final _lastName = TextEditingController(text: widget.services.session.user!.lastName);
  late final _phone = TextEditingController(text: widget.services.session.user!.phoneNumber ?? '');
  bool _saving = false;
  String? _error;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await widget.services.users.updateProfile(
        firstName: _firstName.text.trim(),
        lastName: _lastName.text.trim(),
        phoneNumber: _phone.text.trim().isEmpty ? null : _phone.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).profileSaved)));
        setState(() {});
      }
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = errorText(AppLocalizations.of(context), e));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  // Switches the app language at once and saves it in the account.
  Future<void> _changeLanguage(String code) async {
    await widget.services.language.setLanguage(code);
    final user = widget.services.session.user!;
    try {
      await widget.services.users.updateProfile(
        firstName: user.firstName,
        lastName: user.lastName,
        phoneNumber: user.phoneNumber,
        preferredLanguage: code,
      );
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = errorText(AppLocalizations.of(context), e));
    }
  }

  Future<void> _logout() async {
    final navigator = Navigator.of(context);
    ScaffoldMessenger.of(context).clearSnackBars(); // don't carry messages over to the login screen
    await widget.services.auth.logout();
    navigator.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.services.session.user!;
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.profile)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: MemberAvatar(firstName: user.firstName, lastName: user.lastName, radius: 40)),
                const SizedBox(height: 16),
                InfoRow(t.email, user.email),
                InfoRow(t.plan, user.subscriptionPlan),
                if (user.role == 'ADMIN') InfoRow(t.role, t.adminRole),
                const SizedBox(height: 16),
                LanguagePicker(value: widget.services.language.locale.languageCode, onChanged: _changeLanguage),
                const SizedBox(height: 16),
                if (_error != null) ...[ErrorBanner(_error!), const SizedBox(height: 12)],
                TextFormField(
                  controller: _firstName,
                  decoration: InputDecoration(labelText: t.firstName),
                  validator: (v) => requiredText(v, t.firstNameRequired),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _lastName,
                  decoration: InputDecoration(labelText: t.lastName),
                  validator: (v) => requiredText(v, t.lastNameRequired),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phone,
                  decoration: InputDecoration(labelText: t.phoneOptional, hintText: '+96891234567'),
                  keyboardType: TextInputType.phone,
                  validator: (v) => phoneField(t, v),
                ),
                const SizedBox(height: 20),
                LoadingButton(label: t.save, loading: _saving, onPressed: _save),
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChangePasswordScreen(services: widget.services),
                  )),
                  icon: const Icon(Icons.lock_outline),
                  label: Text(t.changePassword),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  key: const Key('logout-button'),
                  onPressed: _logout,
                  icon: const Icon(Icons.logout),
                  label: Text(t.logOut),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
