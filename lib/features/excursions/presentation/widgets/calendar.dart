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
        clipBehavior: Clip.none,
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
    final colors = context.appColors;
    final textColor = isSelected ? Colors.white : colors.textPrimary;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? colors.primary : colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.calendarTile),
        border: context.isLight
            ? null
            : Border.all(
                strokeAlign: BorderSide.strokeAlignOutside,
                color: isSelected ? colors.primary : colors.border,
                width: 1.3,
              ),
        boxShadow: context.isLight ? AppShadows.calendarShadow : null,
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
                    ).copyWith(color: textColor),
                  ),
                  TextSpan(
                    text: weekday,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
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
