import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/core/ui/segmented_control.dart';
import 'package:guide_manager/features/applications/presentation/application_card.dart';

class ApplicationsPage extends ConsumerWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(applicationsTabProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Заявки')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ApplicationsSegmentedControl(
                value: tab,
                onChanged: (value) {
                  ref.read(applicationsTabProvider.notifier).select(value);
                },
              ),
            ),
            const SizedBox(height: 16),
            const ApplicationCard(),
          ],
        ),
      ),
    );
  }
}
