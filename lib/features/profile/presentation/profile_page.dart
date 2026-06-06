import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/features/auth/data/auth_repository_impl.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Guide profile will be added here.'),
            TextButton(
              onPressed: () async =>
                  await ref.read(authRepositoryProvider).logout(),
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}
