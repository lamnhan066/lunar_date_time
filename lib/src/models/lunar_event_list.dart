import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:lunar_date_time/lunar_date_time.dart';

/// Lớp LunarEventList quản lý danh sách các sự kiện theo lịch âm
class LunarEventList extends BaseEventList<LunarDateTime> with EquatableMixin {
  /// Khởi tạo LunarEventList với danh sách sự kiện
  LunarEventList({required super.events});

  /// Thêm một sự kiện vào ngày cụ thể
  @override
  void add(LunarDateTime date, BaseEvent<LunarDateTime> event) {
    final eventsOfDate = events[date];
    if (eventsOfDate == null) {
      events[date] = [event];
    } else {
      eventsOfDate.add(event);
    }
  }

  /// Thêm nhiều sự kiện vào ngày cụ thể
  @override
  void addAll(LunarDateTime date, List<BaseEvent<LunarDateTime>> events) {
    final eventsOfDate = this.events[date];
    if (eventsOfDate == null) {
      this.events[date] = events;
    } else {
      eventsOfDate.addAll(events);
    }
  }

  /// Xóa một sự kiện khỏi ngày cụ thể
  @override
  bool remove(LunarDateTime date, BaseEvent<LunarDateTime> event) {
    final eventsOfDate = events[date];
    return eventsOfDate != null ? eventsOfDate.remove(event) : false;
  }

  /// Xóa tất cả sự kiện khỏi ngày cụ thể và trả về danh sách sự kiện đã xóa
  @override
  List<BaseEvent<LunarDateTime>> removeAll(LunarDateTime date) {
    return events.remove(date) ?? [];
  }

  /// Xóa toàn bộ danh sách sự kiện
  @override
  void clear() {
    events.clear();
  }

  /// Lấy danh sách sự kiện của một ngày cụ thể
  @override
  List<BaseEvent<LunarDateTime>> getEvents(LunarDateTime date) {
    return events[date] ?? [];
  }

  /// Chuyển đổi danh sách sự kiện sang dạng Map
  /// Map<DateTime dưới dạng microsecondsSinceEpoch, Danh sách LunarEvent>
  @override
  Map<String, dynamic> toMap() {
    final Map<String, List<String>> map = {};
    events.forEach((key, value) {
      map.addAll({
        key.toDateTime().toIso8601String():
            value.map((e) => e.toJson()).toList()
      });
    });

    return {'events': map};
  }

  /// Tạo LunarEventList từ một Map
  factory LunarEventList.fromMap(Map<String, dynamic> map) {
    final events = LunarEventList(events: {});
    final mapEvents = map['events'] as Map<String, dynamic>;
    mapEvents.forEach((key, value) {
      var dateTime = LunarDateTime.fromDateTime(DateTime.parse(key));
      events.addAll(
        dateTime,
        (value as List).map((e) => LunarEvent.fromJson(e.toString())).toList(),
      );
    });
    return events;
  }

  /// Tạo LunarEventList từ một chuỗi JSON
  factory LunarEventList.fromJson(String source) =>
      LunarEventList.fromMap(json.decode(source));

  /// Trả về chuỗi mô tả của LunarEventList
  @override
  String toString() => 'LunarEventList(events: $events)';

  /// Danh sách các thuộc tính để so sánh trong Equatable
  @override
  List<Object> get props => [events];
}
