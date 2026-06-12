import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/app/theme_controller.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          _AppearanceCard(
            themeMode: themeMode,
            onChanged: (mode) async {
              await ref.read(themeModeProvider.notifier).setMode(mode);
            },
          ),
        ],
      ),
    );
  }
}

class _AppearanceCard extends StatelessWidget {
  const _AppearanceCard({required this.themeMode, required this.onChanged});

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: context.isLight ? AppShadows.cardShadow : null,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: context.isDark ? Border.all(color: colors.border) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(LucideIcons.settings, size: 32, color: colors.primary),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Оформление',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Выберите тему приложения',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _ThemeModeSelector(themeMode: themeMode, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector({required this.themeMode, required this.onChanged});

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.surfaceLow,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: SizedBox(
        height: 80,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedAlign(
              alignment: _indicatorAlignment(themeMode),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: FractionallySizedBox(
                widthFactor: 1 / 3,
                heightFactor: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                _ThemeModeOption(
                  mode: ThemeMode.light,
                  currentMode: themeMode,
                  icon: Icons.light_mode_outlined,
                  label: 'Светлая',
                  onTap: onChanged,
                ),
                _ThemeModeOption(
                  mode: ThemeMode.dark,
                  currentMode: themeMode,
                  icon: Icons.dark_mode_outlined,
                  label: 'Тёмная',
                  onTap: onChanged,
                ),
                _ThemeModeOption(
                  mode: ThemeMode.system,
                  currentMode: themeMode,
                  icon: Icons.phone_iphone_outlined,
                  label: 'Системная',
                  onTap: onChanged,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Alignment _indicatorAlignment(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => Alignment.centerLeft,
      ThemeMode.dark => Alignment.center,
      ThemeMode.system => Alignment.centerRight,
    };
  }
}

class _ThemeModeOption extends StatelessWidget {
  const _ThemeModeOption({
    required this.mode,
    required this.currentMode,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final ThemeMode mode;
  final ThemeMode currentMode;
  final IconData icon;
  final String label;
  final ValueChanged<ThemeMode> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isSelected = mode == currentMode;
    final foregroundColor = isSelected ? Colors.white : colors.textPrimary;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(mode),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: isSelected ? Colors.white : colors.textMuted,
                ),
                const SizedBox(height: AppSpacing.sm),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: foregroundColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
