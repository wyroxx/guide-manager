import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guide_manager/app/router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Registration form will be added here.'),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.goNamed(AppRoute.login.name),
                child: const Text('Back to login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
