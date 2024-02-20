import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:lunar_date_time/src/models/base_event_list.dart';

import 'solar_event.dart';

class SolarEventList extends Equatable implements BaseEventList {
  final Map<DateTime, List<SolarEvent>> events;

  SolarEventList({
    required this.events,
  });

  void add(DateTime date, SolarEvent event) {
    final eventsOfDate = events[date];
    if (eventsOfDate == null) {
      events[date] = [event];
    } else {
      eventsOfDate.add(event);
    }
  }

  void addAll(DateTime date, List<SolarEvent> events) {
    final eventsOfDate = this.events[date];
    if (eventsOfDate == null) {
      this.events[date] = events;
    } else {
      eventsOfDate.addAll(events);
    }
  }

  bool remove(DateTime date, SolarEvent event) {
    final eventsOfDate = events[date];
    return eventsOfDate != null ? eventsOfDate.remove(event) : false;
  }

  List<SolarEvent> removeAll(DateTime date) {
    return events.remove(date) ?? [];
  }

  void clear() {
    events.clear();
  }

  List<SolarEvent> getEvents(DateTime date) {
    return events[date] ?? [];
  }

  /// Map<DateTime in microsecondsSinceEpoch, List of Event>
  Map<String, dynamic> toMap() {
    final Map<String, List<String>> map = {};
    events.forEach((key, value) {
      map.addAll(
          {key.toIso8601String(): value.map((e) => e.toJson()).toList()});
    });

    return {'events': map};
  }

  factory SolarEventList.fromMap(Map<String, dynamic> map) {
    final events = SolarEventList(events: {});
    final mapEvents = map['events'] as Map<String, dynamic>;
    mapEvents.forEach((key, value) {
      var dateTime = DateTime.parse(key);
      events.addAll(
        dateTime,
        (value as List).map((e) => SolarEvent.fromJson(e.toString())).toList(),
      );
    });
    return events;
  }

  String toJson() => json.encode(toMap());

  factory SolarEventList.fromJson(String source) =>
      SolarEventList.fromMap(json.decode(source));

  @override
  String toString() => 'LunarEventList(events: $events)';

  @override
  List<Object> get props => [events];
}
