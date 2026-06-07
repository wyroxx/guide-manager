import 'package:flutter/material.dart';
import 'package:guide_manager/core/utils/date_formatter.dart';
import 'package:guide_manager/features/excursions/domain/excursion.dart';

class ExcursionCard extends StatelessWidget {
  const ExcursionCard({super.key, required this.excursion});

  final Excursion excursion;

  @override
  Widget build(BuildContext context) {
    String additional = '';
    if (excursion.hasLunch && excursion.hasMasterclass) {
      additional = '\nОбед и мастеркласс включены';
    } else if (excursion.hasLunch) {
      additional = '\nОбед включен';
    } else if (excursion.hasMasterclass) {
      additional = '\nМастеркласс включен';
    }
    final timeRange = formatTimeRange(excursion.startsDate, excursion.endDate);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    excursion.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 12),
                Text(timeRange, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Место встречи: ${excursion.meetingPlace}\n'
              'Машрут: ${excursion.route}\n'
              'Группа: ${excursion.maxParticipants} человек'
              '$additional',
              style: const TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
