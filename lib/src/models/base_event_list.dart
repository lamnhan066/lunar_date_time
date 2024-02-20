import 'base_event.dart';

abstract class BaseEventList {
  final Map<DateTime, List<BaseEvent>> events;

  BaseEventList({
    required this.events,
  });

  void add(covariant DateTime date, covariant BaseEvent event);

  void addAll(covariant DateTime date, List<BaseEvent> events);

  bool remove(DateTime date, BaseEvent event);

  List<BaseEvent> removeAll(DateTime date);

  void clear();

  List<BaseEvent> getEvents(DateTime date);

  /// Map<DateTime in microsecondsSinceEpoch, List of BaseEvent>
  Map<String, dynamic> toMap();

  String toJson();
}
