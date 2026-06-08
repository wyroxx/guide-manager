import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guide_manager/app/theme.dart';

enum ApplicationsTab { available, pending }

class ApplicationsSegmentedControl extends ConsumerWidget {
  const ApplicationsSegmentedControl({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final ApplicationsTab value;
  final ValueChanged<ApplicationsTab> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoSlidingSegmentedControl<ApplicationsTab>(
      groupValue: value,
      backgroundColor: const Color(0xFF323137),
      thumbColor: const Color(0xFF5A5863),
      padding: const EdgeInsets.all(3),
      children: {
        ApplicationsTab.available: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Доступные',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: value == ApplicationsTab.available
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
        ),
        ApplicationsTab.pending: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Мои заявки',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: value == ApplicationsTab.pending
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
        ),
      },
      onValueChanged: (value) {
        if (value == null) return;
        onChanged(value);
      },
    );
  }
}

class ApplicationsTabNotifier extends Notifier<ApplicationsTab> {
  @override
  ApplicationsTab build() {
    return ApplicationsTab.available;
  }

  void select(ApplicationsTab tab) {
    state = tab;
  }
}

final applicationsTabProvider =
    NotifierProvider<ApplicationsTabNotifier, ApplicationsTab>(
      ApplicationsTabNotifier.new,
    );
