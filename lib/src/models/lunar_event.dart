import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:lunar_date_time/src/lunar_date_time.dart';
import 'package:lunar_date_time/src/models/base_event.dart';

import 'enums.dart';

class LunarRepeat implements BaseRepeat {
  @override
  final LunarDateTime fromDate;
  @override
  final LunarDateTime toDate;
  @override
  final RepeatFrequency frequency;
  @override
  final int every;

  const LunarRepeat({
    required this.fromDate,
    required this.toDate,
    required this.frequency,
    required this.every,
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

  factory LunarRepeat.hourly() {
    return LunarRepeat.every(RepeatFrequency.hourly);
  }

  Map<String, dynamic> toMap() {
    return {
      'fromDate': fromDate.millisecondsSinceEpoch,
      'toDate': toDate.millisecondsSinceEpoch,
      'frequency': frequency.name,
      'every': every,
    };
  }

  factory LunarRepeat.fromMap(Map<String, dynamic> map) {
    final fromDate = LunarDateTime.fromMillisecondsSinceEpoch(map['fromDate']);
    final toDate = LunarDateTime.fromMillisecondsSinceEpoch(map['toDate']);
    return LunarRepeat(
      fromDate: fromDate,
      toDate: toDate,
      frequency: RepeatFrequency.values.byName(map['frequency']),
      every: map['every']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LunarRepeat.fromJson(String source) =>
      LunarRepeat.fromMap(json.decode(source));
}

class LunarEvent extends Equatable implements BaseEvent {
  @override
  final LunarDateTime date;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? location;
  @override
  final int? id;
  @override
  final EventPriority priority;
  @override
  final LunarRepeat repeat;
  @override
  final EventMode mode;
  LunarEvent({
    this.id,
    required this.date,
    required this.title,
    this.description,
    this.location,
    this.mode = EventMode.normal,
    this.priority = EventPriority.medium,
    LunarRepeat? repeat,
  }) : repeat = repeat ?? LunarRepeat.no();

  LunarEvent copyWith({
    LunarDateTime? date,
    String? title,
    String? description,
    EventMode? mode,
    String? location,
    int? id,
    EventPriority? priority,
    LunarRepeat? repeat,
  }) {
    return LunarEvent(
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      mode: mode ?? this.mode,
      location: location ?? this.location,
      id: id ?? this.id,
      priority: priority ?? this.priority,
      repeat: repeat ?? this.repeat,
    );
  }

  /// Kiểm tra xem event này có phù hợp với `date` không.
  bool checkDate(LunarDateTime date) {
    return switch (repeat.frequency) {
      RepeatFrequency.no => _checkNo(date),
      RepeatFrequency.hourly => _checkHourly(date),
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

  bool _checkHourly(LunarDateTime date) {
    if (!_isValidDateInRange(date)) return false;

    final everyInMilliseconds =
        date.millisecondsSinceEpoch - this.date.millisecondsSinceEpoch;
    final every = Duration(milliseconds: everyInMilliseconds).inHours;
    if (every % repeat.every == 0) {
      return true;
    }

    return false;
  }

  bool _checkDaily(LunarDateTime date) {
    if (!_isValidDateInRange(date)) return false;

    final everyInMilliseconds =
        date.millisecondsSinceEpoch - this.date.millisecondsSinceEpoch;
    final every = Duration(milliseconds: everyInMilliseconds).inDays;
    if (every % repeat.every == 0) {
      return true;
    }

    return false;
  }

  bool _checkWeekly(LunarDateTime date) {
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

  bool _checkMonthly(LunarDateTime date) {
    if (!_isValidDateInRange(date)) return false;

    if (this.date.day == date.day) {
      final every = date.month - this.date.month;
      if (every % repeat.every == 0) {
        return true;
      }
    }
    return false;
  }

  bool _checkYearly(LunarDateTime date) {
    if (!_isValidDateInRange(date)) return false;

    if (this.date.day == date.day && this.date.month == date.month) {
      final every = date.year - this.date.year;
      if (every % repeat.every == 0) {
        return true;
      }
    }
    return false;
  }

  /// Currently do not use `repeat.fromDate` to compare because we assume that the
  /// from date is the date that the user first set.
  bool _isValidDateInRange(LunarDateTime date) {
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
    };
  }

  factory LunarEvent.fromMap(Map<String, dynamic> map) {
    final date = LunarDateTime.parse(map['date']);
    return LunarEvent(
      date: date,
      title: map['title'],
      description: map['description'],
      mode: EventMode.values.byName(map['mode']),
      location: map['location'],
      id: map['id']?.toInt(),
      priority: map['priority'] != null
          ? EventPriority.values.byName(map['priority'])
          : EventPriority.medium,
      repeat:
          map['repeat'] != null ? LunarRepeat.fromJson(map['repeat']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LunarEvent.fromJson(String source) =>
      LunarEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LunarEvent(date: $date, title: $title, description: $description, mode: $mode location: $location, id: $id, priority: $priority, repeat: $repeat)';
  }

  @override
  List<Object> get props {
    return [
      date,
      title,
      description ?? '',
      mode,
      location ?? '',
      id ?? '',
      priority,
      repeat.toJson(),
    ];
  }
}
