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
  final bool isEndOfMonth;

  BaseEvent({
    required this.date,
    required this.title,
    required this.description,
    required this.location,
    required this.id,
    required this.priority,
    required this.repeat,
    required this.mode,
    required this.containTime,
    required this.isEndOfMonth,
  });
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
