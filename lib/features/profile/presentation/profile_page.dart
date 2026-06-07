import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/core/ui/adaptive_dialog.dart';
import 'package:guide_manager/features/auth/data/auth_repository_impl.dart';
import 'package:guide_manager/features/profile/data/profile_repository_impl.dart';
import 'package:guide_manager/features/profile/domain/profile_data.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileDataAsync = ref.watch(profileDataProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Center(
        child: profileDataAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/error.svg'),
              const SizedBox(height: 35),
              Text(
                'Не удалось загрузить профиль',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                onPressed: () {
                  ref.invalidate(profileDataProvider);
                },
                child: Text(
                  'Повторить',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: AppColors.link),
                ),
              ),
            ],
          ),
          data: (profileData) {
            if (profileData == null) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/empty_profile.svg'),
                    const SizedBox(height: 16),
                    Text(
                      'Профиль еще не заполнен',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Информация появится после добавления администратором',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SvgPicture.asset('assets/images/avatar.svg'),
                  const SizedBox(height: 16),
                  Text(
                    profileData.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    profileData.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  _ProfileCard(profileData: profileData),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      final confirmed = await showAdaptiveConfirmationDialog(
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '@${profileData.telegramAlias}',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(thickness: 1),
            ),
            Text(
              '+${profileData.phone}',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(thickness: 1),
            ),
            Text(
              'Экскурсий проведено: ${profileData.toursCount}',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(thickness: 1),
            ),
            Text(
              'Уровень: ${profileData.level.name}',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
