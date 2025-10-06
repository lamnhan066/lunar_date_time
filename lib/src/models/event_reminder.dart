import 'package:equatable/equatable.dart';

import 'enums.dart';

class EventReminder extends Equatable {
  const EventReminder({
    required this.value,
    required this.unit,
  });

  final int value;
  final ReminderUnit unit;

  bool get isZero => value == 0;

  EventReminder copyWith({
    int? value,
    ReminderUnit? unit,
  }) {
    return EventReminder(
      value: value ?? this.value,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'unit': unit.name,
    };
  }

  factory EventReminder.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return const EventReminder(value: 0, unit: ReminderUnit.hours);
    }

    return EventReminder(
      value: map['value']?.toInt() ?? 0,
      unit: ReminderUnit.values.byName(map['unit'] ?? ReminderUnit.hours.name),
    );
  }

  static List<EventReminder> listFromDynamic(dynamic data) {
    if (data is Iterable) {
      return data
          .map((e) {
            if (e is EventReminder) return e;
            if (e is Map) {
              return EventReminder.fromMap(e.cast<String, dynamic>());
            }
            return null;
          })
          .whereType<EventReminder>()
          .toList(growable: false);
    }

    if (data is Map<String, dynamic>) {
      return [EventReminder.fromMap(data)];
    }

    return const [];
  }

  @override
  List<Object> get props => [value, unit];
}
