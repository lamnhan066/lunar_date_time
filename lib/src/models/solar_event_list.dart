import 'dart:convert';

import 'package:lunar_date_time/lunar_date_time.dart';

/// Lớp đại diện cho danh sách các sự kiện dựa trên SolarDateTime
class SolarEventList extends BaseEventList<SolarDateTime> {
  /// Khởi tạo danh sách sự kiện với các sự kiện được truyền vào
  SolarEventList({required super.events});

  /// Thêm một sự kiện vào danh sách tại một ngày cụ thể
  @override
  void add(SolarDateTime date, BaseEvent<SolarDateTime> event) {
    final eventsOfDate = events[date];
    if (eventsOfDate == null) {
      events[date] = [event];
    } else {
      eventsOfDate.add(event);
    }
  }

  /// Thêm nhiều sự kiện vào danh sách tại một ngày cụ thể
  @override
  void addAll(SolarDateTime date, List<BaseEvent<SolarDateTime>> events) {
    final eventsOfDate = this.events[date];
    if (eventsOfDate == null) {
      this.events[date] = events;
    } else {
      eventsOfDate.addAll(events);
    }
  }

  /// Xóa một sự kiện khỏi danh sách tại một ngày cụ thể
  @override
  bool remove(SolarDateTime date, BaseEvent<SolarDateTime> event) {
    final eventsOfDate = events[date];
    return eventsOfDate != null ? eventsOfDate.remove(event) : false;
  }

  /// Xóa tất cả các sự kiện tại một ngày cụ thể và trả về danh sách các sự kiện đã xóa
  @override
  List<BaseEvent<SolarDateTime>> removeAll(SolarDateTime date) {
    return events.remove(date) ?? [];
  }

  /// Xóa toàn bộ danh sách sự kiện
  @override
  void clear() {
    events.clear();
  }

  /// Lấy danh sách các sự kiện tại một ngày cụ thể
  @override
  List<BaseEvent<SolarDateTime>> getEvents(SolarDateTime date) {
    return events[date] ?? [];
  }

  /// Chuyển đổi danh sách sự kiện thành một Map
  /// Map<SolarDateTime dưới dạng ISO8601 string, Danh sách các sự kiện>
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

  /// Tạo một SolarEventList từ một Map
  factory SolarEventList.fromMap(Map<String, dynamic> map) {
    final events = SolarEventList(events: {});
    final mapEvents = map['events'] as Map<String, dynamic>;
    mapEvents.forEach((key, value) {
      var solarDateTime = SolarDateTime.fromDateTime(Utc7.parse(key));
      events.addAll(
        solarDateTime,
        (value as List).map((e) => SolarEvent.fromJson(e.toString())).toList(),
      );
    });
    return events;
  }

  /// Chuyển đổi danh sách sự kiện thành chuỗi JSON
  @override
  String toJson() => json.encode(toMap());

  /// Tạo một SolarEventList từ chuỗi JSON
  factory SolarEventList.fromJson(String source) =>
      SolarEventList.fromMap(json.decode(source));

  /// Trả về chuỗi mô tả của SolarEventList
  @override
  String toString() => 'SolarEventList(events: $events)';
}
