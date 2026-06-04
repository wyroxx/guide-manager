import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guide_manager/app/router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Login form will be added here.'),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.goNamed(AppRoute.register.name),
                child: const Text('Create account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
