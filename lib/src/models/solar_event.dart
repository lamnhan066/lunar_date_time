import 'dart:convert';

import 'package:lunar_date_time/lunar_date_time.dart';

/// Lớp đại diện cho việc lặp lại sự kiện theo lịch dương.
class SolarRepeat extends BaseRepeat<SolarDateTime> {
  /// Khởi tạo một đối tượng SolarRepeat.
  const SolarRepeat({
    required super.fromDate,
    required super.toDate,
    required super.frequency,
    required super.every,
  });

  /// Tạo một bản sao của SolarRepeat với các giá trị mới.
  SolarRepeat copyWith({
    SolarDateTime? fromDate,
    SolarDateTime? toDate,
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

  /// Tạo một SolarRepeat không lặp lại.
  factory SolarRepeat.no() {
    return SolarRepeat.every(RepeatFrequency.no);
  }

  /// Tạo một SolarRepeat với tần suất lặp lại cụ thể.
  factory SolarRepeat.every(RepeatFrequency frequency) {
    return SolarRepeat(
      fromDate: SolarDateTime(1900),
      toDate: SolarDateTime(3000),
      frequency: frequency,
      every: 1,
    );
  }

  /// Tạo một SolarRepeat lặp lại hàng năm.
  factory SolarRepeat.yearly() {
    return SolarRepeat.every(RepeatFrequency.yearly);
  }

  /// Tạo một SolarRepeat lặp lại hàng tháng.
  factory SolarRepeat.monthly() {
    return SolarRepeat.every(RepeatFrequency.monthly);
  }

  /// Tạo một SolarRepeat lặp lại hàng tuần.
  factory SolarRepeat.weekly() {
    return SolarRepeat.every(RepeatFrequency.weekly);
  }

  /// Tạo một SolarRepeat lặp lại hàng ngày.
  factory SolarRepeat.daily() {
    return SolarRepeat.every(RepeatFrequency.daily);
  }

  /// Tạo một SolarRepeat từ một Map.
  factory SolarRepeat.fromMap(Map<String, dynamic> map) {
    final fromDate = map['fromDate'] is int
        ? DateTime.fromMillisecondsSinceEpoch(map['fromDate'])
        : DateTime.parse(map['fromDate']);
    final toDate = map['toDate'] is int
        ? DateTime.fromMillisecondsSinceEpoch(map['toDate'])
        : DateTime.parse(map['toDate']);
    return SolarRepeat(
      fromDate: fromDate.toSolar(),
      toDate: toDate.toSolar(),
      frequency: RepeatFrequency.values.byName(map['frequency']),
      every: map['every']?.toInt() ?? 0,
    );
  }

  /// Tạo một SolarRepeat từ một chuỗi JSON.
  factory SolarRepeat.fromJson(String source) =>
      SolarRepeat.fromMap(json.decode(source));

  /// Trả về chuỗi mô tả đối tượng SolarRepeat.
  @override
  String toString() {
    return 'SolarRepeat(fromDate: $fromDate, toDate: $toDate, frequency: $frequency, every: $every)';
  }

  /// Các thuộc tính để so sánh đối tượng.
  @override
  List<Object> get props => [fromDate, toDate, frequency, every];

  /// Chuyển đổi đối tượng SolarRepeat thành Map.
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

/// Lớp đại diện cho một sự kiện theo lịch dương.
class SolarEvent extends BaseEvent<SolarDateTime> {
  /// Khởi tạo một đối tượng SolarEvent.
  SolarEvent({
    super.id = '',
    required super.date,
    required super.title,
    super.description = '',
    super.location = '',
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

  /// Tạo một SolarEvent từ một BaseEvent.
  factory SolarEvent.fromBaseEvent(BaseEvent<SolarDateTime> event) {
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

  /// Tạo một bản sao của SolarEvent với các giá trị mới.
  SolarEvent copyWith({
    SolarDateTime? date,
    String? title,
    String? description,
    EventMode? mode,
    String? location,
    String? id,
    EventPriority? priority,
    BaseRepeat<SolarDateTime>? repeat,
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

  /// Kiểm tra xem sự kiện này có phù hợp với ngày `date` không.
  bool checkDate(SolarDateTime date) {
    return switch (repeat.frequency) {
      RepeatFrequency.no => _checkNo(date),
      RepeatFrequency.daily => _checkDaily(date),
      RepeatFrequency.weekly => _checkWeekly(date),
      RepeatFrequency.monthly => _checkMonthly(date),
      RepeatFrequency.yearly => _checkYearly(date),
    };
  }

  /// Kiểm tra sự kiện không lặp lại.
  bool _checkNo(SolarDateTime date) {
    if (this.date.day == date.day &&
        this.date.month == date.month &&
        this.date.year == date.year) {
      return true;
    }
    return false;
  }

  /// Kiểm tra sự kiện lặp lại hàng ngày.
  bool _checkDaily(SolarDateTime date) {
    if (!_isValidDateInRange(date)) return false;

    final everyInMilliseconds = date.toDateTime().millisecondsSinceEpoch -
        this.date.toDateTime().millisecondsSinceEpoch;
    final every = Duration(milliseconds: everyInMilliseconds).inDays;
    if (every % repeat.every == 0) {
      return true;
    }

    return false;
  }

  /// Kiểm tra sự kiện lặp lại hàng tuần.
  bool _checkWeekly(SolarDateTime date) {
    if (!_isValidDateInRange(date)) return false;

    if (this.date.weekday == date.weekday) {
      final everyInMilliseconds = date.toDateTime().millisecondsSinceEpoch -
          this.date.toDateTime().millisecondsSinceEpoch;
      final every = Duration(milliseconds: everyInMilliseconds).inDays;
      if (every % (repeat.every * 7) == 0) {
        return true;
      }
    }
    return false;
  }

  /// Kiểm tra sự kiện lặp lại hàng tháng.
  bool _checkMonthly(SolarDateTime date) {
    if (!_isValidDateInRange(date)) return false;

    if (isEndOfMonth) {
      final tomorrow = date.toDateTime().add(Duration(days: 1)).toSolar();
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
  bool _checkYearly(SolarDateTime date) {
    if (!_isValidDateInRange(date)) return false;

    if (this.date.month == date.month) {
      if (isEndOfMonth) {
        final tomorrow = date.toDateTime().add(Duration(days: 1)).toSolar();
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
  bool _isValidDateInRange(SolarDateTime date) {
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
    return dateDT.isAfter(this.date.toDateTime()) &&
        dateDT.isBefore(repeat.toDate.toDateTime());
  }

  /// Tạo một SolarEvent từ một Map.
  factory SolarEvent.fromMap(Map map) {
    return SolarEvent(
      date: (map['date'] is int
              ? DateTime.fromMillisecondsSinceEpoch(map['date'])
              : DateTime.parse(map['date']))
          .toSolar(),
      title: map['title'],
      description: map['description'] ?? '',
      mode: EventMode.values.byName(map['mode']),
      location: map['location'] ?? '',
      id: map['id'] ?? '',
      priority: map['priority'] != null
          ? EventPriority.values.byName(map['priority'])
          : EventPriority.medium,
      repeat:
          map['repeat'] != null ? SolarRepeat.fromJson(map['repeat']) : null,
      containTime: map['containTime'],
      isEndOfMonth: map['isEndOfMonth'],
      createdDate: map['createdDate'] is int
          ? DateTime.fromMillisecondsSinceEpoch(map['createdDate'])
          : DateTime.parse(map['createdDate']),
    );
  }

  /// Tạo một SolarEvent từ một chuỗi JSON.
  factory SolarEvent.fromJson(String source) =>
      SolarEvent.fromMap(json.decode(source));

  /// Trả về chuỗi mô tả đối tượng SolarEvent.
  @override
  String toString() {
    return 'SolarEvent(date: $date, title: $title, description: $description, mode: $mode location: $location, id: $id, priority: $priority, repeat: $repeat, containTime: $containTime, isEndOfMonth: $isEndOfMonth, createdDate: $createdDate)';
  }

  /// Chuyển đổi đối tượng SolarEvent thành Map.
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
