const _shortWeekdays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

const _fullWeekdays = [
  'понедельник',
  'вторник',
  'среда',
  'четверг',
  'пятница',
  'суббота',
  'воскресенье',
];

const _months = [
  'января',
  'февраля',
  'марта',
  'апреля',
  'мая',
  'июня',
  'июля',
  'августа',
  'сентября',
  'октября',
  'ноября',
  'декабря',
];

(String day, String weekday) formatCalendarDate(DateTime date) {
  return (date.day.toString(), _shortWeekdays[date.weekday - 1]);
}

String formatDateTitle(DateTime date) {
  return '${date.day} ${_months[date.month - 1]}, '
      '${_fullWeekdays[date.weekday - 1]}';
}

String formatDate(DateTime date) {
  return '${date.day} ${_months[date.month - 1]}';
}

String formatTime(DateTime date) {
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');

  return '$hour:$minute';
}

String formatTimeRange(DateTime start, DateTime end) {
  return '${formatTime(start)}-${formatTime(end)}';
}
