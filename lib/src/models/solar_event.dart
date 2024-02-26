import 'dart:convert';

import 'package:lunar_date_time/src/models/base_event.dart';

import 'enums.dart';

class SolarRepeat extends BaseRepeat<DateTime> {
  const SolarRepeat({
    required super.fromDate,
    required super.toDate,
    required super.frequency,
    required super.every,
  });

  @override
  SolarRepeat copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    RepeatFrequency? frequency,
    int? every,
  }) {
    return SolarRepeat(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      frequency: frequency ?? this.frequency,
      every: every ?? this.every,
    );
  }

  factory SolarRepeat.no() {
    return SolarRepeat.every(RepeatFrequency.no);
  }

  factory SolarRepeat.every(RepeatFrequency frequency) {
    return SolarRepeat(
      fromDate: DateTime(1900),
      toDate: DateTime(3000),
      frequency: frequency,
      every: 1,
    );
  }

  factory SolarRepeat.yearly() {
    return SolarRepeat.every(RepeatFrequency.yearly);
  }

  factory SolarRepeat.monthly() {
    return SolarRepeat.every(RepeatFrequency.monthly);
  }

  factory SolarRepeat.weekly() {
    return SolarRepeat.every(RepeatFrequency.weekly);
  }

  factory SolarRepeat.daily() {
    return SolarRepeat.every(RepeatFrequency.daily);
  }

  factory SolarRepeat.hourly() {
    return SolarRepeat.every(RepeatFrequency.hourly);
  }

  factory SolarRepeat.fromMap(Map<String, dynamic> map) {
    final fromDate = DateTime.fromMillisecondsSinceEpoch(map['fromDate']);
    final toDate = DateTime.fromMillisecondsSinceEpoch(map['toDate']);
    return SolarRepeat(
      fromDate: fromDate,
      toDate: toDate,
      frequency: RepeatFrequency.values.byName(map['frequency']),
      every: map['every']?.toInt() ?? 0,
    );
  }

  factory SolarRepeat.fromJson(String source) =>
      SolarRepeat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SolarRepeat(fromDate: $fromDate, toDate: $toDate, frequency: $frequency, every: $every)';
  }

  @override
  List<Object> get props => [fromDate, toDate, frequency, every];
}

class SolarEvent extends BaseEvent<DateTime> {
  SolarEvent({
    super.id,
    required super.date,
    required super.title,
    super.description,
    super.location,
    super.mode = EventMode.normal,
    super.priority = EventPriority.medium,
    SolarRepeat? repeat,
    super.containTime = false,
    super.isEndOfMonth = false,
    DateTime? createdDate,
  }) : super(
          repeat: repeat ?? SolarRepeat.no(),
          createdDate: createdDate ?? DateTime.now(),
        );

  factory SolarEvent.fromBaseEvent(BaseEvent event) {
    return SolarEvent(
      id: event.id,
      date: event.date,
      title: event.title,
      description: event.description,
      location: event.location,
      mode: event.mode,
      priority: event.priority,
      repeat: SolarRepeat(
        fromDate: event.repeat.fromDate,
        toDate: event.repeat.toDate,
        frequency: event.repeat.frequency,
        every: event.repeat.every,
      ),
      containTime: event.containTime,
      isEndOfMonth: event.isEndOfMonth,
      createdDate: event.createdDate,
    );
  }

  @override
  SolarEvent copyWith({
    DateTime? date,
    String? title,
    String? description,
    EventMode? mode,
    String? location,
    String? id,
    EventPriority? priority,
    BaseRepeat<DateTime>? repeat,
    bool? containTime,
    bool? isEndOfMonth,
    DateTime? createdDate,
  }) {
    return SolarEvent(
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      id: id ?? this.id,
      priority: priority ?? this.priority,
      repeat: (repeat ?? this.repeat) as SolarRepeat,
      mode: mode ?? this.mode,
      containTime: containTime ?? this.containTime,
      isEndOfMonth: isEndOfMonth ?? this.isEndOfMonth,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  /// Kiểm tra xem event này có phù hợp với `date` không.
  bool checkDate(DateTime date) {
    return switch (repeat.frequency) {
      RepeatFrequency.no => _checkNo(date),
      RepeatFrequency.hourly => _checkHourly(date),
      RepeatFrequency.daily => _checkDaily(date),
      RepeatFrequency.weekly => _checkWeekly(date),
      RepeatFrequency.monthly => _checkMonthly(date),
      RepeatFrequency.yearly => _checkYearly(date),
    };
  }

  bool _checkNo(DateTime date) {
    if (this.date.day == date.day &&
        this.date.month == date.month &&
        this.date.year == date.year) {
      return true;
    }
    return false;
  }

  bool _checkHourly(DateTime date) {
    if (!_isValidDateInRange(date)) return false;

    final everyInMilliseconds =
        date.millisecondsSinceEpoch - this.date.millisecondsSinceEpoch;
    final every = Duration(milliseconds: everyInMilliseconds).inHours;
    if (every % repeat.every == 0) {
      return true;
    }

    return false;
  }

  bool _checkDaily(DateTime date) {
    if (!_isValidDateInRange(date)) return false;

    final everyInMilliseconds =
        date.millisecondsSinceEpoch - this.date.millisecondsSinceEpoch;
    final every = Duration(milliseconds: everyInMilliseconds).inDays;
    if (every % repeat.every == 0) {
      return true;
    }

    return false;
  }

  bool _checkWeekly(DateTime date) {
    if (!_isValidDateInRange(date)) return false;

    if (this.date.weekday == date.weekday) {
      final everyInMilliseconds =
          date.millisecondsSinceEpoch - this.date.millisecondsSinceEpoch;
      final every = Duration(milliseconds: everyInMilliseconds).inDays;
      if (every % (repeat.every * 7) == 0) {
        return true;
      }
    }
    return false;
  }

  bool _checkMonthly(DateTime date) {
    if (!_isValidDateInRange(date)) return false;

    if (isEndOfMonth) {
      final tomorrow = date.add(Duration(days: 1));
      if (tomorrow.day == 1) {
        final every = date.month - this.date.month;
        if (every % repeat.every == 0) {
          return true;
        }
      }
    } else if (this.date.day == date.day) {
      final every = date.month - this.date.month;
      if (every % repeat.every == 0) {
        return true;
      }
    }
    return false;
  }

  bool _checkYearly(DateTime date) {
    if (!_isValidDateInRange(date)) return false;

    if (this.date.month == date.month) {
      if (isEndOfMonth) {
        final tomorrow = date.add(Duration(days: 1));
        if (tomorrow.day == 1) {
          final every = date.year - this.date.year;
          if (every % repeat.every == 0) {
            return true;
          }
        }
      } else if (this.date.day == date.day) {
        final every = date.year - this.date.year;
        if (every % repeat.every == 0) {
          return true;
        }
      }
    }
    return false;
  }

  /// Currently do not use `repeat.fromDate` to compare because we assume that the
  /// from date is the date that the user first set.
  bool _isValidDateInRange(DateTime date) {
    if (this.date.day == date.day &&
        this.date.month == date.month &&
        this.date.year == date.year) {
      return true;
    }
    if (repeat.toDate.day == date.day &&
        repeat.toDate.month == date.month &&
        repeat.toDate.year == date.year) {
      return true;
    }
    return date.isAfter(this.date) && date.isBefore(repeat.toDate);
  }

  factory SolarEvent.fromMap(Map<String, dynamic> map) {
    return SolarEvent(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      title: map['title'],
      description: map['description'],
      mode: EventMode.values.byName(map['mode']),
      location: map['location'],
      id: map['id'],
      priority: map['priority'] != null
          ? EventPriority.values.byName(map['priority'])
          : EventPriority.medium,
      repeat:
          map['repeat'] != null ? SolarRepeat.fromJson(map['repeat']) : null,
      containTime: map['containTime'],
      isEndOfMonth: map['isEndOfMonth'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
    );
  }

  factory SolarEvent.fromJson(String source) =>
      SolarEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SolarEvent(date: $date, title: $title, description: $description, mode: $mode location: $location, id: $id, priority: $priority, repeat: $repeat, containTime: $containTime, isEndOfMonth: $isEndOfMonth, createdDate: $createdDate)';
  }
}
