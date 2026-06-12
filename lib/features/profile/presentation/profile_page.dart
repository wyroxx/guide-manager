import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:guide_manager/app/router.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/core/ui/adaptive_dialog.dart';
import 'package:guide_manager/core/ui/empty_state.dart';
import 'package:guide_manager/core/ui/error_state.dart';
import 'package:guide_manager/features/auth/data/auth_repository_impl.dart';
import 'package:guide_manager/features/profile/data/profile_repository_impl.dart';
import 'package:guide_manager/features/profile/domain/profile_data.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileDataAsync = ref.watch(profileDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(AppRoute.settings.name),
            tooltip: 'Настройки',
            icon: const Icon(LucideIcons.settings),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: Center(
        child: profileDataAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => AppErrorState(
            title: 'Не удалось загрузить профиль',
            onRetry: () {
              ref.invalidate(profileDataProvider);
            },
          ),
          data: (profileData) {
            if (profileData == null) {
              return const AppEmptyState(
                title: 'Профиль еще не заполнен',
                subtitle:
                    'Информация появится после добавления администратором',
                assetPath: 'assets/images/empty_profile.svg',
                padding: EdgeInsets.symmetric(horizontal: 12),
                imageTitleSpacing: 16,
              );
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          profileData.avatar.isEmpty
                              ? SvgPicture.asset(
                                  'assets/images/avatar.svg',
                                  height: 160,
                                  width: 160,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Image.network(
                                    profileData.avatar,
                                    height: 160,
                                    width: 160,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          const SizedBox(height: 16),
                          Text(
                            profileData.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            profileData.email,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          _ProfileCard(profileData: profileData),
                          const Spacer(),
                          TextButton(
                            onPressed: () async {
                              final confirmed =
                                  await showAdaptiveConfirmationDialog(
                                    context,
                                    title: 'Выйти из аккаунта?',
                                    message:
                                        'Чтобы получить доступ вам нужно будет зайти повторно',
                                    confirmText: 'Выйти',
                                    cancelText: 'Отменить',
                                  );
                              if (confirmed) {
                                await ref.read(authRepositoryProvider).logout();
                              }
                            },
                            child: const Text('Выйти из аккаунта'),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.profileData});

  final ProfileData profileData;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: context.isLight ? AppShadows.cardShadow : null,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@${profileData.telegramAlias}',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: colors.textPrimary),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(thickness: 1),
              ),
              Text(
                '+${profileData.phone}',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: colors.textPrimary),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(thickness: 1),
              ),
              Text(
                'Экскурсий проведено: ${profileData.toursCount}',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: colors.textPrimary),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(thickness: 1),
              ),
              Text(
                'Уровень: ${profileData.level.nameRus}',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: colors.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
