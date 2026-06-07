import 'package:flutter/material.dart';
import 'package:guide_manager/app/theme.dart';
import 'package:guide_manager/core/utils/date_formatter.dart';

class Calendar extends StatelessWidget {
  const Calendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final today = DateUtils.dateOnly(DateTime.now());
    return SizedBox(
      height: 66,
      child: ListView.separated(
        itemBuilder: (context, index) {
          final date = today.add(Duration(days: index));
          return _CalendarItem(
            date: date,
            isSelected: DateUtils.isSameDay(date, selectedDate),
            onTap: () => onDateSelected(date),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemCount: 21,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class _CalendarItem extends StatelessWidget {
  const _CalendarItem({
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final formattedDate = formatCalendarDate(date);
    final String day = formattedDate.$1;
    final String weekday = formattedDate.$2;
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryDark : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.calendarTile),
        border: Border.all(
          color: isSelected ? AppColors.primaryDark : AppColors.border,
          width: 1.3,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.calendarTile),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.calendarTile),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: '$day\n',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: weekday,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
