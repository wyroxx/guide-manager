import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/core/logging/app_logger.dart';
import 'package:guide_manager/core/ui/empty_state.dart';
import 'package:guide_manager/core/ui/error_state.dart';
import 'package:guide_manager/core/ui/segmented_control.dart';
import 'package:guide_manager/core/ui/snack_bar.dart';
import 'package:guide_manager/features/applications/data/applications_repository_impl.dart';
import 'package:guide_manager/features/applications/presentation/application_card.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';
import 'package:guide_manager/features/profile/data/profile_repository_impl.dart';

class ApplicationsPage extends ConsumerStatefulWidget {
  const ApplicationsPage({super.key});

  @override
  ConsumerState<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends ConsumerState<ApplicationsPage> {
  final Set<String> _submittingExcursionIds = {};

  @override
  Widget build(BuildContext context) {
    final tab = ref.watch(applicationsTabProvider);
    final profileDataAsync = ref.watch(profileDataProvider);
    Widget content;

    if (profileDataAsync.isLoading) {
      content = const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (profileDataAsync.hasError) {
      content = Expanded(
        child: AppErrorState(
          title: 'Не удалось проверить аккаунт',
          onRetry: () {
            ref.invalidate(profileDataProvider);
          },
        ),
      );
    } else if (profileDataAsync.value == null) {
      content = const Expanded(
        child: AppEmptyState(
          assetPath: 'assets/images/empty_applications.svg',
          title: 'Нет доступных экскурсий',
          subtitle: 'Они появятся после одобрения аккаунта',
        ),
      );
    } else if (tab == ApplicationsTab.available) {
      content = Expanded(
        child: ref
            .watch(availableExcursionsProvider)
            .when(
              data: (excursions) {
                if (excursions.isEmpty) {
                  return const AppEmptyState(
                    assetPath: 'assets/images/empty_applications.svg',
                    title: 'Нет доступных экскурсий',
                    subtitle: 'Они скоро появятся',
                  );
                }
                return ListView.separated(
                  itemBuilder: (context, index) => ApplicationCard.available(
                    excursion: excursions[index],
                    isLoading: _submittingExcursionIds.contains(
                      excursions[index].id,
                    ),
                    onApply: () async {
                      await _applyToExcursion(context, excursions[index]);
                    },
                  ),
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
                  return const AppEmptyState(
                    assetPath: 'assets/images/empty_applications.svg',
                    title: 'Заявок пока нет',
                    subtitle: 'Отправленные заявки появятся здесь',
                  );
                }
                return ListView.separated(
                  itemBuilder: (context, index) =>
                      ApplicationCard.submitted(application: excursions[index]),
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

  Future<void> _applyToExcursion(
    BuildContext context,
    Excursion excursion,
  ) async {
    if (_submittingExcursionIds.contains(excursion.id)) return;

    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    if (user == null || email == null || email.isEmpty) {
      showAppToast(
        context,
        message: 'Пользователь не авторизован',
        type: AppToastType.error,
      );
      return;
    }

    setState(() {
      _submittingExcursionIds.add(excursion.id);
    });

    try {
      await ref
          .read(applicationsRepositoryProvider)
          .applyToExcursion(
            excursion: excursion,
            guideUid: user.uid,
            guideEmail: email,
          );

      ref.invalidate(availableExcursionsProvider);
      ref.invalidate(myApplicationsProvider);

      if (!context.mounted) return;
      showAppToast(
        context,
        message: 'Заявка отправлена',
        type: AppToastType.success,
      );
    } catch (error, stackTrace) {
      ref
          .read(appLoggerProvider)
          .error(
            'Applications',
            'Failed to submit application for ${excursion.id} '
                '(company: ${excursion.companyId})',
            error: error,
            stackTrace: stackTrace,
          );
      if (!context.mounted) return;
      showAppToast(
        context,
        message: 'Не удалось отправить заявку',
        type: AppToastType.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _submittingExcursionIds.remove(excursion.id);
        });
      }
    }
  }
}
