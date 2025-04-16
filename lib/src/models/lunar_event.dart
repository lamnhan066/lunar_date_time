import 'dart:convert';

import 'package:lunar_date_time/lunar_date_time.dart';

/// Lớp đại diện cho việc lặp lại sự kiện theo lịch âm.
class LunarRepeat extends BaseRepeat<LunarDateTime> {
  /// Tạo một đối tượng LunarRepeat.
  const LunarRepeat({
    required super.fromDate,
    required super.toDate,
    required super.frequency,
    required super.every,
  });

  /// Tạo một bản sao của LunarRepeat với các giá trị được thay đổi.
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

  /// Tạo một LunarRepeat không lặp lại.
  factory LunarRepeat.no() {
    return LunarRepeat.every(RepeatFrequency.no);
  }

  /// Tạo một LunarRepeat lặp lại với tần suất cụ thể.
  factory LunarRepeat.every(RepeatFrequency frequency) {
    return LunarRepeat(
      fromDate: LunarDateTime(1900),
      toDate: LunarDateTime(3000),
      frequency: frequency,
      every: 1,
    );
  }

  /// Tạo một LunarRepeat lặp lại hàng năm.
  factory LunarRepeat.yearly() {
    return LunarRepeat.every(RepeatFrequency.yearly);
  }

  /// Tạo một LunarRepeat lặp lại hàng tháng.
  factory LunarRepeat.monthly() {
    return LunarRepeat.every(RepeatFrequency.monthly);
  }

  /// Tạo một LunarRepeat lặp lại hàng tuần.
  factory LunarRepeat.weekly() {
    return LunarRepeat.every(RepeatFrequency.weekly);
  }

  /// Tạo một LunarRepeat lặp lại hàng ngày.
  factory LunarRepeat.daily() {
    return LunarRepeat.every(RepeatFrequency.daily);
  }

  /// Tạo một LunarRepeat từ một Map.
  factory LunarRepeat.fromMap(Map<String, dynamic> map) {
    final fromDate = map['fromDate'] is int
        ? LunarDateTime.fromDateTime(
            DateTime.fromMillisecondsSinceEpoch(map['fromDate']))
        : LunarDateTime.fromDateTime(DateTime.parse(map['fromDate']));
    final toDate = map['toDate'] is int
        ? LunarDateTime.fromDateTime(
            DateTime.fromMillisecondsSinceEpoch(map['toDate']))
        : LunarDateTime.fromDateTime(DateTime.parse(map['toDate']));
    return LunarRepeat(
      fromDate: fromDate,
      toDate: toDate,
      frequency: RepeatFrequency.values.byName(map['frequency']),
      every: map['every']?.toInt() ?? 0,
    );
  }

  /// Tạo một LunarRepeat từ một chuỗi JSON.
  factory LunarRepeat.fromJson(String source) =>
      LunarRepeat.fromMap(json.decode(source));

  /// Chuyển đổi đối tượng LunarRepeat thành chuỗi.
  @override
  String toString() {
    return 'LunarRepeat(fromDate: $fromDate, toDate: $toDate, frequency: $frequency, every: $every)';
  }

  /// Chuyển đổi đối tượng LunarRepeat thành Map.
  @override
  Map<String, dynamic> toMap() {
    return {
      'fromDate': fromDate.toDateTime().toIso8601String(),
      'toDate': toDate.toDateTime().toIso8601String(),
      'frequency': frequency.name,
      'every': every,
    };
  }
}

/// Lớp đại diện cho sự kiện theo lịch âm.
class LunarEvent extends BaseEvent<LunarDateTime> {
  /// Tạo một đối tượng LunarEvent.
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

  /// Tạo một LunarEvent từ một BaseEvent.
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

  /// Tạo một bản sao của LunarEvent với các giá trị được thay đổi.
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

  /// Kiểm tra xem sự kiện này có phù hợp với ngày `date` không.
  bool checkDate(LunarDateTime date) {
    return switch (repeat.frequency) {
      RepeatFrequency.no => _checkNo(date),
      RepeatFrequency.daily => _checkDaily(date),
      RepeatFrequency.weekly => _checkWeekly(date),
      RepeatFrequency.monthly => _checkMonthly(date),
      RepeatFrequency.yearly => _checkYearly(date),
    };
  }

  /// Kiểm tra sự kiện không lặp lại.
  bool _checkNo(LunarDateTime date) {
    if (this.date.day == date.day &&
        this.date.month == date.month &&
        this.date.year == date.year) {
      return true;
    }
    return false;
  }

  /// Kiểm tra sự kiện lặp lại hàng ngày.
  bool _checkDaily(LunarDateTime date) {
    if (!isValidDateInRange(date)) return false;

    final thisDT = this.date.toDateTime();
    final dateDT = date.toDateTime();

    final everyInMilliseconds =
        dateDT.millisecondsSinceEpoch - thisDT.millisecondsSinceEpoch;
    final every = Duration(milliseconds: everyInMilliseconds).inDays;
    if (every % repeat.every == 0) {
      return true;
    }

    return false;
  }

  /// Kiểm tra sự kiện lặp lại hàng tuần.
  bool _checkWeekly(LunarDateTime date) {
    if (!isValidDateInRange(date)) return false;

    final thisDT = this.date.toDateTime();
    final dateDT = date.toDateTime();

    if (thisDT.weekday == dateDT.weekday) {
      final everyInMilliseconds =
          dateDT.millisecondsSinceEpoch - thisDT.millisecondsSinceEpoch;
      final every = Duration(milliseconds: everyInMilliseconds).inDays;
      if (every % (repeat.every * 7) == 0) {
        return true;
      }
    }
    return false;
  }

  /// Kiểm tra sự kiện lặp lại hàng tháng.
  bool _checkMonthly(LunarDateTime date) {
    if (!isValidDateInRange(date)) return false;

    if (isEndOfMonth) {
      final tomorrow =
          LunarDateTime.fromDateTime(date.toDateTime().add(Duration(days: 1)));
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

  /// Kiểm tra sự kiện lặp lại hàng năm.
  bool _checkYearly(LunarDateTime date) {
    if (!isValidDateInRange(date)) return false;

    if (this.date.month == date.month) {
      if (isEndOfMonth) {
        final tomorrow = LunarDateTime.fromDateTime(
            date.toDateTime().add(Duration(days: 1)));
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

  /// Kiểm tra xem ngày có nằm trong phạm vi hợp lệ không.
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

    final dateDT = date.toDateTime();
    return dateDT.isAfter(date.toDateTime()) &&
        dateDT.isBefore(repeat.toDate.toDateTime());
  }

  /// Tạo một LunarEvent từ một Map.
  factory LunarEvent.fromMap(Map map) {
    return LunarEvent(
      date: map['date'] is int
          ? LunarDateTime.fromDateTime(
              DateTime.fromMillisecondsSinceEpoch(map['date']))
          : LunarDateTime.fromDateTime(DateTime.parse(map['date'])),
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

  /// Tạo một LunarEvent từ một chuỗi JSON.
  factory LunarEvent.fromJson(String source) =>
      LunarEvent.fromMap(json.decode(source));

  /// Chuyển đổi đối tượng LunarEvent thành chuỗi.
  @override
  String toString() {
    return 'LunarEvent(date: $date, title: $title, description: $description, mode: $mode location: $location, id: $id, priority: $priority, repeat: $repeat, containTime: $containTime, isEndOfMonth: $isEndOfMonth, createdDate: $createdDate)';
  }

  /// Chuyển đổi đối tượng LunarEvent thành Map.
  @override
  Map<String, dynamic> toMap() {
    return {
      'date': date.toDateTime().toIso8601String(),
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
