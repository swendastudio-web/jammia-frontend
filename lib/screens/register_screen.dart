import 'package:flutter/material.dart';

import '../widgets/language_picker.dart';
import '../utils/error_text.dart';
import '../l10n/app_localizations.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../utils/validators.dart';
import '../widgets/error_banner.dart';
import '../widgets/loading_button.dart';

/// Create an account. On success the user is logged in straight away.
class RegisterScreen extends StatefulWidget {
  final AppServices services;

  const RegisterScreen({super.key, required this.services});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await widget.services.auth.register(
        firstName: _firstName.text.trim(),
        lastName: _lastName.text.trim(),
        email: _email.text.trim(),
        password: _password.text,
        preferredLanguage: widget.services.language.locale.languageCode,
      );
      // Logged in: close this screen; the app now shows "My rooms".
      if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
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
      appBar: AppBar(title: Text(t.createAccount)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_error != null) ...[ErrorBanner(_error!), const SizedBox(height: 16)],
                // Changing the language here switches the app at once and is saved with the account.
                LanguagePicker(
                  value: widget.services.language.locale.languageCode,
                  onChanged: widget.services.language.setLanguage,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('register-first-name'),
                  controller: _firstName,
                  decoration: InputDecoration(labelText: t.firstName),
                  textCapitalization: TextCapitalization.words,
                  validator: (v) => requiredText(v, t.firstNameRequired),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const Key('register-last-name'),
                  controller: _lastName,
                  decoration: InputDecoration(labelText: t.lastName),
                  textCapitalization: TextCapitalization.words,
                  validator: (v) => requiredText(v, t.lastNameRequired),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const Key('register-email'),
                  controller: _email,
                  decoration: InputDecoration(labelText: t.email),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => emailField(t, v),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const Key('register-password'),
                  controller: _password,
                  decoration: InputDecoration(labelText: t.password, helperText: t.passwordHelper),
                  obscureText: true,
                  validator: (v) => passwordField(t, v),
                ),
                const SizedBox(height: 24),
                LoadingButton(label: t.createAccount, loading: _loading, onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
