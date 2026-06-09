import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/core/ui/empty_state.dart';
import 'package:guide_manager/core/ui/error_state.dart';
import 'package:guide_manager/core/ui/segmented_control.dart';
import 'package:guide_manager/features/applications/data/applications_repository_impl.dart';
import 'package:guide_manager/features/applications/presentation/application_card.dart';

class ApplicationsPage extends ConsumerWidget {
  const ApplicationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(applicationsTabProvider);
    Widget content;
    if (tab == ApplicationsTab.available) {
      content = Expanded(
        child: ref
            .watch(availableExcursionsProvider)
            .when(
              data: (excursions) {
                if (excursions.isEmpty) {
                  return const AppEmptyState(
                    title: 'Доступных экскурсий сейчас нет',
                  );
                }
                return ListView.separated(
                  itemBuilder: (context, index) =>
                      ApplicationCard(excursion: excursions[index]),
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemCount: excursions.length,
                );
              },
              error: (error, stackTrace) => AppErrorState(
                title: 'Не удалось загрузить экскурсии',
                onRetry: () {
                  ref.invalidate(availableExcursionsProvider);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
      );
    } else {
      content = Expanded(
        child: ref
            .watch(myApplicationsProvider)
            .when(
              data: (excursions) {
                if (excursions.isEmpty) {
                  return const AppEmptyState(title: 'Заявок нет');
                }
                return ListView.separated(
                  itemBuilder: (context, index) =>
                      ApplicationCard(excursion: excursions[index]),
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemCount: excursions.length,
                );
              },
              error: (error, stackTrace) => AppErrorState(
                title: 'Не удалось загрузить заявки',
                onRetry: () {
                  ref.invalidate(myApplicationsProvider);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Заявки')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
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
            const SizedBox(height: 20),
            content,
          ],
        ),
      ),
    );
  }
}
