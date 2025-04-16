import 'dart:convert';

import 'package:lunar_date_time/lunar_date_time.dart';

class LunarRepeat extends BaseRepeat<LunarDateTime> {
  const LunarRepeat({
    required super.fromDate,
    required super.toDate,
    required super.frequency,
    required super.every,
  });

  LunarRepeat copyWith({
    LunarDateTime? fromDate,
    LunarDateTime? toDate,
    RepeatFrequency? frequency,
    int? every,
  }) {
    return LunarRepeat(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      frequency: frequency ?? this.frequency,
      every: every ?? this.every,
    );
  }

  factory LunarRepeat.no() {
    return LunarRepeat.every(RepeatFrequency.no);
  }

  factory LunarRepeat.every(RepeatFrequency frequency) {
    return LunarRepeat(
      fromDate: LunarDateTime(1900),
      toDate: LunarDateTime(3000),
      frequency: frequency,
      every: 1,
    );
  }

  factory LunarRepeat.yearly() {
    return LunarRepeat.every(RepeatFrequency.yearly);
  }

  factory LunarRepeat.monthly() {
    return LunarRepeat.every(RepeatFrequency.monthly);
  }

  factory LunarRepeat.weekly() {
    return LunarRepeat.every(RepeatFrequency.weekly);
  }

  factory LunarRepeat.daily() {
    return LunarRepeat.every(RepeatFrequency.daily);
  }

  // factory LunarRepeat.hourly() {
  //   return LunarRepeat.every(RepeatFrequency.hourly);
  // }

  factory LunarRepeat.fromMap(Map<String, dynamic> map) {
    final fromDate = map['fromDate'] is int
        ? LunarDateTime.fromMillisecondsSinceEpoch(map['fromDate'])
        : LunarDateTime.parse(map['fromDate']);
    final toDate = map['toDate'] is int
        ? LunarDateTime.fromMillisecondsSinceEpoch(map['toDate'])
        : LunarDateTime.parse(map['toDate']);
    return LunarRepeat(
      fromDate: fromDate,
      toDate: toDate,
      frequency: RepeatFrequency.values.byName(map['frequency']),
      every: map['every']?.toInt() ?? 0,
    );
  }

  factory LunarRepeat.fromJson(String source) =>
      LunarRepeat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LunarRepeat(fromDate: $fromDate, toDate: $toDate, frequency: $frequency, every: $every)';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'frequency': frequency.name,
      'every': every,
    };
  }
}

class LunarEvent extends BaseEvent<LunarDateTime> {
  LunarEvent({
    super.id = '',
    required super.date,
    required super.title,
    super.description = '',
    super.location = '',
    super.mode = EventMode.normal,
    super.priority = EventPriority.medium,
    LunarRepeat? repeat,
    super.containTime = false,
    super.isEndOfMonth = false,
    DateTime? createdDate,
  }) : super(
          repeat: repeat ?? LunarRepeat.no(),
          createdDate: createdDate ?? DateTime.now(),
        );

  factory LunarEvent.fromBaseEvent(BaseEvent<LunarDateTime> event) {
    return LunarEvent(
      id: event.id,
      date: event.date,
      title: event.title,
      description: event.description,
      location: event.location,
      mode: event.mode,
      priority: event.priority,
      repeat: LunarRepeat(
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

  LunarEvent copyWith({
    LunarDateTime? date,
    String? title,
    String? description,
    EventMode? mode,
    String? location,
    String? id,
    EventPriority? priority,
    BaseRepeat<LunarDateTime>? repeat,
    bool? containTime,
    bool? isEndOfMonth,
    DateTime? createdDate,
  }) {
    return LunarEvent(
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      id: id ?? this.id,
      priority: priority ?? this.priority,
      repeat: (repeat ?? this.repeat) as LunarRepeat,
      mode: mode ?? this.mode,
      containTime: containTime ?? this.containTime,
      isEndOfMonth: isEndOfMonth ?? this.isEndOfMonth,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  /// Kiểm tra xem event này có phù hợp với `date` không.
  bool checkDate(LunarDateTime date) {
    return switch (repeat.frequency) {
      RepeatFrequency.no => _checkNo(date),
      // RepeatFrequency.hourly => checkHourly(date),
      RepeatFrequency.daily => _checkDaily(date),
      RepeatFrequency.weekly => _checkWeekly(date),
      RepeatFrequency.monthly => _checkMonthly(date),
      RepeatFrequency.yearly => _checkYearly(date),
    };
  }

  bool _checkNo(LunarDateTime date) {
    if (this.date.day == date.day &&
        this.date.month == date.month &&
        this.date.year == date.year) {
      return true;
    }
    return false;
  }

  bool _checkDaily(LunarDateTime date) {
    if (!isValidDateInRange(date)) return false;

    final everyInMilliseconds =
        date.millisecondsSinceEpoch - this.date.millisecondsSinceEpoch;
    final every = Duration(milliseconds: everyInMilliseconds).inDays;
    if (every % repeat.every == 0) {
      return true;
    }

    return false;
  }

  bool _checkWeekly(LunarDateTime date) {
    if (!isValidDateInRange(date)) return false;

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

  bool _checkMonthly(LunarDateTime date) {
    if (!isValidDateInRange(date)) return false;

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

  bool _checkYearly(LunarDateTime date) {
    if (!isValidDateInRange(date)) return false;

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
  bool isValidDateInRange(LunarDateTime date) {
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

  factory LunarEvent.fromMap(Map map) {
    return LunarEvent(
      date: map['date'] is int
          ? LunarDateTime.fromMillisecondsSinceEpoch(map['date'])
          : LunarDateTime.parse(map['date']),
      title: map['title'],
      description: map['description'] ?? '',
      mode: EventMode.values.byName(map['mode']),
      location: map['location'] ?? '',
      id: map['id'] ?? '',
      priority: map['priority'] != null
          ? EventPriority.values.byName(map['priority'])
          : EventPriority.medium,
      repeat:
          map['repeat'] != null ? LunarRepeat.fromJson(map['repeat']) : null,
      containTime: map['containTime'],
      isEndOfMonth: map['isEndOfMonth'],
      createdDate: map['createdDate'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['createdDate'])
          : DateTime.parse(map['createdDate']),
    );
  }

  factory LunarEvent.fromJson(String source) =>
      LunarEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LunarEvent(date: $date, title: $title, description: $description, mode: $mode location: $location, id: $id, priority: $priority, repeat: $repeat, containTime: $containTime, isEndOfMonth: $isEndOfMonth, createdDate: $createdDate)';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'title': title,
      'description': description,
      'mode': mode.name,
      'location': location,
      'id': id,
      'priority': priority.name,
      'repeat': repeat.toJson(),
      'containTime': containTime,
      'isEndOfMonth': isEndOfMonth,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
