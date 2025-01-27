import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'enums.dart';

class BaseEvent<D extends DateTime> extends Equatable {
  final D date;
  final String title;
  final String? description;
  final String? location;
  final String? id;
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

  BaseEvent<D> copyWith({
    D? date,
    String? title,
    String? description,
    EventMode? mode,
    String? location,
    String? id,
    EventPriority? priority,
    BaseRepeat<D>? repeat,
    bool? containTime,
    bool? isEndOfMonth,
    DateTime? createdDate,
  }) {
    return BaseEvent<D>(
      date: date ?? this.date,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      id: id ?? this.id,
      priority: priority ?? this.priority,
      repeat: repeat ?? this.repeat,
      mode: mode ?? this.mode,
      containTime: containTime ?? this.containTime,
      isEndOfMonth: isEndOfMonth ?? this.isEndOfMonth,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
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
    };
  }

  String toJson() => json.encode(toMap());

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

class BaseRepeat<D extends DateTime> extends Equatable {
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

  BaseRepeat<D> copyWith({
    D? fromDate,
    D? toDate,
    RepeatFrequency? frequency,
    int? every,
  }) {
    return BaseRepeat<D>(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      frequency: frequency ?? this.frequency,
      every: every ?? this.every,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
      'frequency': frequency.name,
      'every': every,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [fromDate, toDate, frequency, every];
}
