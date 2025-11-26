import 'dart:convert';

import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:lunar_date_time/src/models/check_date_mixin.dart';
import 'package:timezone/timezone.dart' as tz;

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
  @override
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
            Utc7.fromMillisecondsSinceEpoch(map['fromDate']))
        : LunarDateTime.fromDateTime(Utc7.parse(map['fromDate']));
    final toDate = map['toDate'] is int
        ? LunarDateTime.fromDateTime(
            Utc7.fromMillisecondsSinceEpoch(map['toDate']))
        : LunarDateTime.fromDateTime(Utc7.parse(map['toDate']));
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
class LunarEvent extends BaseEvent<LunarDateTime>
    with CheckDateMixin<LunarDateTime> {
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
    tz.TZDateTime? createdDate,
    List<EventReminder> reminders = const [],
  }) : super(
          repeat: repeat ?? LunarRepeat.no(),
          createdDate: createdDate ?? Utc7.now(),
          reminders: reminders,
        );

  /// Tạo một LunarEvent từ một BaseEvent.
  static LunarEvent fromBaseEvent<T extends BaseDateTime>(
    BaseEvent<T> event,
  ) {
    return LunarEvent(
      id: event.id,
      date: event.date is LunarDateTime
          ? event.date as LunarDateTime
          : event.date.toUtc().toLunar(),
      title: event.title,
      description: event.description,
      location: event.location,
      mode: event.mode,
      priority: event.priority,
      repeat: LunarRepeat(
        fromDate: event.repeat.fromDate is LunarDateTime
            ? event.repeat.fromDate as LunarDateTime
            : event.repeat.fromDate.toUtc().toLunar(),
        toDate: event.repeat.toDate is LunarDateTime
            ? event.repeat.toDate as LunarDateTime
            : event.repeat.toDate.toUtc().toLunar(),
        frequency: event.repeat.frequency,
        every: event.repeat.every,
      ),
      containTime: event.containTime,
      isEndOfMonth: event.isEndOfMonth,
      createdDate: event.createdDate,
      reminders: event.reminders,
    );
  }

  /// Tạo một bản sao của LunarEvent với các giá trị được thay đổi.
  @override
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
    tz.TZDateTime? createdDate,
    List<EventReminder>? reminders,
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
      reminders: reminders ?? this.reminders,
    );
  }

  /// Tạo một LunarEvent từ một Map.
  factory LunarEvent.fromMap(Map map) {
    return LunarEvent(
      date: map['date'] is int
          ? LunarDateTime.fromDateTime(
              Utc7.fromMillisecondsSinceEpoch(map['date']))
          : LunarDateTime.fromDateTime(Utc7.parse(map['date'])),
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
          ? Utc7.fromMillisecondsSinceEpoch(map['createdDate'])
          : Utc7.parse(map['createdDate']),
      reminders: EventReminder.listFromDynamic(map['reminders']),
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
      'reminders': reminders.map((e) => e.toMap()).toList(growable: false),
    };
  }
}
