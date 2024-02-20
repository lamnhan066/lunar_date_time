class LunarDate {
  final int year;
  final int month;
  final int day;
  final bool isLeapMonth;
  final int julianDayNumber;
  LunarDate({
    required this.year,
    required this.month,
    required this.day,
    required this.isLeapMonth,
    required this.julianDayNumber,
  });
}
