import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/core/ui/empty_state.dart';
import 'package:guide_manager/core/ui/error_state.dart';
import 'package:guide_manager/core/utils/date_formatter.dart';
import 'package:guide_manager/features/excursions/data/excursions_repository_impl.dart';
import 'package:guide_manager/features/excursions/presentation/widgets/calendar.dart';
import 'package:guide_manager/features/excursions/presentation/widgets/excursion_card.dart';
import 'package:guide_manager/features/profile/data/profile_repository_impl.dart';

class ExcursionsPage extends ConsumerStatefulWidget {
  const ExcursionsPage({super.key});

  @override
  ConsumerState<ExcursionsPage> createState() => _ExcursionsPageState();
}

class _ExcursionsPageState extends ConsumerState<ExcursionsPage> {
  DateTime _selectedDate = DateUtils.dateOnly(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final provider = excursionsProvider(_selectedDate);
    final profileDataAsync = ref.watch(profileDataProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Мои экскурсии')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Calendar(
              selectedDate: _selectedDate,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = DateUtils.dateOnly(date);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            child: Text(
              formatDateTitle(_selectedDate),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: profileDataAsync.when(
              data: (profileData) {
                if (profileData == null) {
                  return const AppEmptyState(
                    title: 'Экскурсии не найдены',
                    subtitle: 'Они появятся после одобрения аккаунта',
                  );
                }

                return ref
                    .watch(provider)
                    .when(
                      skipLoadingOnRefresh: false,
                      data: (excursions) {
                        if (excursions.isEmpty) {
                          return const AppEmptyState(
                            title: 'На этот день экскурсий нет',
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: ListView.separated(
                            itemBuilder: (context, index) =>
                                ExcursionCard(excursion: excursions[index]),
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 10),
                            itemCount: excursions.length,
                          ),
                        );
                      },
                      error: (error, stackTrace) => AppErrorState(
                        title: 'Не удалось загрузить экскурсии',
                        onRetry: () {
                          ref.invalidate(provider);
                        },
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    );
              },
              error: (error, stackTrace) => AppErrorState(
                title: 'Не удалось проверить аккаунт',
                onRetry: () {
                  ref.invalidate(profileDataProvider);
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
