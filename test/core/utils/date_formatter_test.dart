import 'package:flutter_test/flutter_test.dart';
import 'package:guide_manager/core/utils/date_formatter.dart';

void main() {
  final date = DateTime(2026, 6, 10, 9, 5);
  final endDate = DateTime(2026, 6, 10, 11, 30);

  test('formats calendar item and date title', () {
    expect(formatCalendarDate(date), ('10', 'Ср'));
    expect(formatDateTitle(date), '10 июня, среда');
  });

  test('formats date and time', () {
    expect(formatDate(date), '10 июня');
    expect(formatTime(date), '09:05');
  });

  test('formatTimeRange returns formatted range', () {
    expect(formatTimeRange(date, endDate), '09:05-11:30');
  });
}
