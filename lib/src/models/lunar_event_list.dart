import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:lunar_date_time/lunar_date_time.dart';

class LunarEventList extends Equatable implements BaseEventList {
  final Map<LunarDateTime, List<LunarEvent>> events;

  LunarEventList({
    required this.events,
  });

  void add(LunarDateTime date, LunarEvent event) {
    final eventsOfDate = events[date];
    if (eventsOfDate == null) {
      events[date] = [event];
    } else {
      eventsOfDate.add(event);
    }
  }

  void addAll(LunarDateTime date, List<LunarEvent> events) {
    final eventsOfDate = this.events[date];
    if (eventsOfDate == null) {
      this.events[date] = events;
    } else {
      eventsOfDate.addAll(events);
    }
  }

  bool remove(LunarDateTime date, LunarEvent event) {
    final eventsOfDate = events[date];
    return eventsOfDate != null ? eventsOfDate.remove(event) : false;
  }

  List<LunarEvent> removeAll(LunarDateTime date) {
    return events.remove(date) ?? [];
  }

  void clear() {
    events.clear();
  }

  List<LunarEvent> getEvents(LunarDateTime date) {
    return events[date] ?? [];
  }

  /// Map<DateTime in microsecondsSinceEpoch, List of LunarEvent>
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

  String toJson() => json.encode(toMap());

  factory LunarEventList.fromJson(String source) =>
      LunarEventList.fromMap(json.decode(source));

  @override
  String toString() => 'LunarEventList(events: $events)';

  @override
  List<Object> get props => [events];
}
