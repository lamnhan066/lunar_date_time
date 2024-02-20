import 'enums.dart';

class BaseEvent {
  final DateTime date;
  final String title;
  final String? description;
  final String? location;
  final int? id;
  final EventPriority priority;
  final BaseRepeat repeat;
  final EventMode mode;
  final bool containTime;

  BaseEvent(
    this.date,
    this.title,
    this.description,
    this.location,
    this.id,
    this.priority,
    this.repeat,
    this.mode,
    this.containTime,
  );
}

class BaseRepeat {
  final DateTime fromDate;
  final DateTime toDate;
  final RepeatFrequency frequency;
  final int every;

  const BaseRepeat({
    required this.fromDate,
    required this.toDate,
    required this.frequency,
    required this.every,
  });
}
