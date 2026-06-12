import 'package:flutter/material.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/core/enums.dart';
import 'package:guide_manager/core/utils/date_formatter.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';

class ApplicationCard extends StatelessWidget {
  const ApplicationCard({super.key, required this.excursion, this.onApply});

  final Excursion excursion;
  final VoidCallback? onApply;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: context.isLight ? AppShadows.cardShadow : null,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      excursion.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${formatDate(excursion.startDate)} ${formatTime(excursion.startDate)}, ${excursion.maxParticipants} чел.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              onApply == null
                  ? StatusBadge(status: excursion.application!.status)
                  : FilledButton(
                      onPressed: onApply,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        minimumSize: const Size(0, 40),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Податься',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final ApplicationStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    if (status == ApplicationStatus.accepted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: colors.accepted.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Text(
          status.statusRus,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontSize: 14,
            color: colors.accepted,
          ),
        ),
      );
    } else if (status == ApplicationStatus.rejected) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: colors.rejected.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Text(
          status.statusRus,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontSize: 14,
            color: colors.rejected,
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colors.pending,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Text(
        status.statusRus,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14),
      ),
    );
  }
}
