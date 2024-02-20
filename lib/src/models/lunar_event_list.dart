import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:lunar_date_time/lunar_date_time.dart';

class LunarEventList extends Equatable implements BaseEventList {
  @override
  final Map<LunarDateTime, List<LunarEvent>> events;

  LunarEventList({
    required this.events,
  });

  @override
  void add(LunarDateTime date, LunarEvent event) {
    final eventsOfDate = events[date];
    if (eventsOfDate == null) {
      events[date] = [event];
    } else {
      eventsOfDate.add(event);
    }
  }

  @override
  void addAll(covariant LunarDateTime date, covariant List<LunarEvent> events) {
    final eventsOfDate = this.events[date];
    if (eventsOfDate == null) {
      this.events[date] = events;
    } else {
      eventsOfDate.addAll(events);
    }
  }

  @override
  bool remove(covariant LunarDateTime date, covariant LunarEvent event) {
    final eventsOfDate = events[date];
    return eventsOfDate != null ? eventsOfDate.remove(event) : false;
  }

  @override
  List<LunarEvent> removeAll(covariant LunarDateTime date) {
    return events.remove(date) ?? [];
  }

  @override
  void clear() {
    events.clear();
  }

  @override
  List<LunarEvent> getEvents(covariant LunarDateTime date) {
    return events[date] ?? [];
  }

  /// Map<DateTime in microsecondsSinceEpoch, List of LunarEvent>
  @override
  Map<String, dynamic> toMap() {
    final Map<String, List<String>> map = {};
    events.forEach((key, value) {
      map.addAll(
          {key.toIso8601String(): value.map((e) => e.toJson()).toList()});
    });

    return {'events': map};
  }

  factory LunarEventList.fromMap(Map<String, dynamic> map) {
    final events = LunarEventList(events: {});
    final mapEvents = map['events'] as Map<String, dynamic>;
    mapEvents.forEach((key, value) {
      var dateTime = LunarDateTime.parse(key);
      events.addAll(
        dateTime,
        (value as List).map((e) => LunarEvent.fromJson(e.toString())).toList(),
      );
    });
    return events;
  }

  @override
  String toJson() => json.encode(toMap());

  factory LunarEventList.fromJson(String source) =>
      LunarEventList.fromMap(json.decode(source));

  @override
  String toString() => 'LunarEventList(events: $events)';

  @override
  List<Object> get props => [events];
}
