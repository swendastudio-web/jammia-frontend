import 'package:flutter/material.dart';

import '../utils/error_text.dart';
import '../l10n/app_localizations.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../utils/validators.dart';
import '../widgets/error_banner.dart';
import '../widgets/loading_button.dart';

/// Change your password. All your other devices are signed out; this one stays signed in.
class ChangePasswordScreen extends StatefulWidget {
  final AppServices services;

  const ChangePasswordScreen({super.key, required this.services});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _new = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _current.dispose();
    _new.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await widget.services.users.changePassword(_current.text, _new.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).passwordChanged)),
      );
      Navigator.of(context).pop();
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
      appBar: AppBar(title: Text(t.changePassword)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_error != null) ...[ErrorBanner(_error!), const SizedBox(height: 12)],
                TextFormField(
                  controller: _current,
                  decoration: InputDecoration(labelText: t.currentPassword),
                  obscureText: true,
                  validator: (v) => (v == null || v.isEmpty) ? t.currentPasswordRequired : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _new,
                  decoration: InputDecoration(labelText: t.newPassword, helperText: t.passwordHelper),
                  obscureText: true,
                  validator: (v) => passwordField(t, v),
                ),
                const SizedBox(height: 24),
                LoadingButton(label: t.changePassword, loading: _loading, onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
