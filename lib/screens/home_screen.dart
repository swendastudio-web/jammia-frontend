import 'package:flutter/material.dart';

/// Temporary first screen. It will be replaced when we build login.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JAMIA')),
      body: const Center(
        child: Text('Welcome to JAMIA'),
      ),
    );
  }
}
