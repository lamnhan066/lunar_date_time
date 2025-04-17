import 'package:lunar_date_time/lunar_date_time.dart';

mixin CheckDateMixin<D extends BaseDateTime> on BaseEvent<D> {
  /// Kiểm tra xem sự kiện này có phù hợp với ngày `date` không.
  bool checkDate(D dateToCheck) {
    return switch (repeat.frequency) {
      RepeatFrequency.no => _checkNo(dateToCheck),
      RepeatFrequency.daily => _checkDaily(dateToCheck),
      RepeatFrequency.weekly => _checkWeekly(dateToCheck),
      RepeatFrequency.monthly => _checkMonthly(dateToCheck),
      RepeatFrequency.yearly => _checkYearly(dateToCheck),
    };
  }

  bool _checkNo(D dateToCheck) {
    return _isSameDay(date, dateToCheck);
  }

  bool _checkDaily(D dateToCheck) {
    if (!_isValidDateInRange(dateToCheck)) return false;

    final diff = dateToCheck.toDateTime().difference(date.toDateTime()).inDays;
    return diff % repeat.every == 0;
  }

  bool _checkWeekly(D dateToCheck) {
    if (!_isValidDateInRange(dateToCheck)) return false;

    final start = date.toDateTime();
    final check = dateToCheck.toDateTime();

    if (start.weekday == check.weekday) {
      final weeksDiff = check.difference(start).inDays ~/ 7;
      return weeksDiff % repeat.every == 0;
    }

    return false;
  }

  bool _checkMonthly(D dateToCheck) {
    if (!_isValidDateInRange(dateToCheck)) return false;

    if (isEndOfMonth) {
      final tomorrow =
          dateToCheck.toDateTime().add(Duration(days: 1)).toSolar();
      if (tomorrow.day == 1) {
        final monthsDiff = (dateToCheck.month - date.month) +
            12 * (dateToCheck.year - date.year);
        return monthsDiff % repeat.every == 0;
      }
    } else if (date.day == dateToCheck.day) {
      final monthsDiff = (dateToCheck.month - date.month) +
          12 * (dateToCheck.year - date.year);
      return monthsDiff % repeat.every == 0;
    }

    return false;
  }

  bool _checkYearly(D dateToCheck) {
    if (!_isValidDateInRange(dateToCheck)) return false;

    if (date.month == dateToCheck.month) {
      if (isEndOfMonth) {
        final tomorrow =
            dateToCheck.toDateTime().add(Duration(days: 1)).toSolar();
        if (tomorrow.day == 1) {
          final yearsDiff = dateToCheck.year - date.year;
          return yearsDiff % repeat.every == 0;
        }
      } else if (date.day == dateToCheck.day) {
        final yearsDiff = dateToCheck.year - date.year;
        return yearsDiff % repeat.every == 0;
      }
    }

    return false;
  }

  bool _isValidDateInRange(D check) {
    if (_isSameDay(date, check) || _isSameDay(repeat.toDate, check)) {
      return true;
    }

    final checkDT = check.toDateTime();
    return checkDT.isAfter(date.toDateTime()) &&
        checkDT.isBefore(repeat.toDate.toDateTime());
  }

  bool _isSameDay(D a, D b) {
    return a.day == b.day && a.month == b.month && a.year == b.year;
  }
}
