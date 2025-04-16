import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'enums.dart';

abstract class BaseEvent<D extends Object> extends Equatable {
  final D date;
  final String title;
  final String description;
  final String location;
  final String id;
  final EventPriority priority;
  final BaseRepeat<D> repeat;
  final EventMode mode;
  final bool containTime;
  final bool isEndOfMonth;
  final DateTime createdDate;

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
    required this.createdDate,
  });

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap();

  @override
  List<Object?> get props {
    return [
      date,
      title,
      description,
      location,
      id,
      priority,
      repeat,
      mode,
      containTime,
      isEndOfMonth,
      createdDate,
    ];
  }
}

abstract class BaseRepeat<D extends Object> extends Equatable {
  final D fromDate;
  final D toDate;
  final RepeatFrequency frequency;
  final int every;

  const BaseRepeat({
    required this.fromDate,
    required this.toDate,
    required this.frequency,
    required this.every,
  });

  String toJson() => jsonEncode(toMap());
  Map<String, dynamic> toMap();

  @override
  List<Object> get props => [fromDate, toDate, frequency, every];
}
