const months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

DateTime getDateTimeFromInt(int date) =>
    DateTime.fromMillisecondsSinceEpoch(date);

String getMonthDayFromInt(int date) {
  final dateTime = getDateTimeFromInt(date);

  return '${months[dateTime.month - 1]} ${dateTime.day}';
}
