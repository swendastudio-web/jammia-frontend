import 'package:flutter/material.dart';

import '../utils/error_text.dart';
import '../l10n/app_localizations.dart';
import '../services/api_exception.dart';
import '../services/app_services.dart';
import '../utils/validators.dart';
import '../widgets/error_banner.dart';
import '../widgets/loading_button.dart';
import 'register_screen.dart';

/// Log in with email and password.
/// When login succeeds, the session changes and the app shows "My rooms" by itself.
class LoginScreen extends StatefulWidget {
  final AppServices services;

  const LoginScreen({super.key, required this.services});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
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
      await widget.services.auth.login(_email.text.trim(), _password.text);
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('JAMIA', textAlign: TextAlign.center, style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 4),
                  Text(t.appTagline, textAlign: TextAlign.center),
                  const SizedBox(height: 32),
                  if (_error != null) ...[ErrorBanner(_error!), const SizedBox(height: 16)],
                  TextFormField(
                    key: const Key('login-email'),
                    controller: _email,
                    decoration: InputDecoration(labelText: t.email),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    validator: (v) => emailField(t, v),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('login-password'),
                    controller: _password,
                    decoration: InputDecoration(labelText: t.password),
                    obscureText: true,
                    autofillHints: const [AutofillHints.password],
                    validator: (v) => (v == null || v.isEmpty) ? t.passwordRequired : null,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 24),
                  LoadingButton(label: t.logIn, loading: _loading, onPressed: _submit),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _loading
                        ? null
                        : () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => RegisterScreen(services: widget.services),
                            )),
                    child: Text(t.noAccountSignUp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
