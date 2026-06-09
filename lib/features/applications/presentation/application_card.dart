import 'package:flutter/material.dart';
import 'package:guide_manager/core/utils/date_formatter.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';

class ApplicationCard extends StatelessWidget {
  const ApplicationCard({super.key, required this.excursion, this.onApply});

  final Excursion excursion;
  final VoidCallback? onApply;

  @override
  Widget build(BuildContext context) {
    return Card(
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
            const SizedBox(width: 10),
            SizedBox(
              child: FilledButton(
                onPressed: onApply,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  minimumSize: const Size(0, 40),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  disabledBackgroundColor: const Color(0xFF5A5863),
                ),
                child: Text(
                  onApply == null
                      ? '${excursion.application?.status.statusRus}'
                      : 'Податься',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
