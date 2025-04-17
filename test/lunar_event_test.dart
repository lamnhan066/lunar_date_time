import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:test/test.dart';

void main() {
  group('LunarEvent', () {
    test('fromBaseEvent creates a LunarEvent from a BaseEvent', () {
      final baseEvent = LunarEvent(
        id: '1',
        date: LunarDateTime(2025, 5, 12),
        title: 'Base Event',
        description: 'Base Event Description',
        location: 'Base Location',
        mode: EventMode.normal,
        priority: EventPriority.high,
        repeat: LunarRepeat.daily(),
        containTime: true,
        isEndOfMonth: false,
        createdDate: DateTime(2025, 5, 1),
      );

      final lunarEvent = LunarEvent.fromBaseEvent(baseEvent);

      expect(lunarEvent.id, equals(baseEvent.id));
      expect(lunarEvent.date, equals(baseEvent.date));
      expect(lunarEvent.title, equals(baseEvent.title));
      expect(lunarEvent.description, equals(baseEvent.description));
      expect(lunarEvent.location, equals(baseEvent.location));
      expect(lunarEvent.mode, equals(baseEvent.mode));
      expect(lunarEvent.priority, equals(baseEvent.priority));
      expect(lunarEvent.repeat, isA<LunarRepeat>());
      expect(lunarEvent.containTime, equals(baseEvent.containTime));
      expect(lunarEvent.isEndOfMonth, equals(baseEvent.isEndOfMonth));
      expect(lunarEvent.createdDate, equals(baseEvent.createdDate));
    });

    test('copyWith creates a copy with updated values', () {
      final event = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Original Event',
        description: 'Original Description',
        location: 'Original Location',
        mode: EventMode.normal,
        priority: EventPriority.medium,
        repeat: LunarRepeat.daily(),
        containTime: false,
        isEndOfMonth: false,
        createdDate: DateTime(2025, 5, 1),
      );

      final updatedEvent = event.copyWith(
        title: 'Updated Event',
        description: 'Updated Description',
        priority: EventPriority.high,
      );

      expect(updatedEvent.title, equals('Updated Event'));
      expect(updatedEvent.description, equals('Updated Description'));
      expect(updatedEvent.priority, equals(EventPriority.high));
      expect(updatedEvent.date, equals(event.date));
      expect(updatedEvent.location, equals(event.location));
      expect(updatedEvent.mode, equals(event.mode));
      expect(updatedEvent.repeat, equals(event.repeat));
      expect(updatedEvent.containTime, equals(event.containTime));
      expect(updatedEvent.isEndOfMonth, equals(event.isEndOfMonth));
      expect(updatedEvent.createdDate, equals(event.createdDate));
    });

    test('checkDate validates non-repeating event correctly', () {
      final event = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Non-Repeating Event',
        repeat: LunarRepeat.no(),
      );

      expect(event.checkDate(LunarDateTime(2025, 5, 12)), isTrue);
      expect(event.checkDate(LunarDateTime(2025, 5, 13)), isFalse);
    });

    test('checkDate validates daily repeating event correctly', () {
      final event = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Daily Event',
        repeat: LunarRepeat.daily(),
      );

      expect(event.checkDate(LunarDateTime(2025, 5, 12)), isTrue);
      expect(event.checkDate(LunarDateTime(2025, 5, 13)), isTrue);
      expect(event.checkDate(LunarDateTime(2025, 5, 14)), isTrue);
    });

    test('checkDate validates weekly repeating event correctly', () {
      final event = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Weekly Event',
        repeat: LunarRepeat.weekly(),
      );

      expect(event.checkDate(LunarDateTime(2025, 5, 19)), isTrue);
      expect(event.checkDate(LunarDateTime(2025, 5, 26)), isTrue);
      expect(event.checkDate(LunarDateTime(2025, 5, 13)), isFalse);
    });

    test('checkDate validates monthly repeating event correctly', () {
      final event = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Monthly Event',
        repeat: LunarRepeat.monthly(),
      );

      expect(event.checkDate(LunarDateTime(2025, 6, 12)), isTrue);
      expect(event.checkDate(LunarDateTime(2025, 7, 12)), isTrue);
      expect(event.checkDate(LunarDateTime(2025, 6, 13)), isFalse);
    });

    test('checkDate validates yearly repeating event correctly', () {
      final event = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Yearly Event',
        repeat: LunarRepeat.yearly(),
      );

      expect(event.checkDate(LunarDateTime(2026, 5, 12)), isTrue);
      expect(event.checkDate(LunarDateTime(2027, 5, 12)), isTrue);
      expect(event.checkDate(LunarDateTime(2026, 5, 13)), isFalse);
    });

    test('toMap and fromMap work correctly', () {
      final event = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Mapped Event',
        description: 'Mapped Description',
        location: 'Mapped Location',
        mode: EventMode.normal,
        priority: EventPriority.medium,
        repeat: LunarRepeat.daily(),
        containTime: false,
        isEndOfMonth: false,
        createdDate: DateTime(2025, 5, 1),
      );

      final map = event.toMap();
      final recreatedEvent = LunarEvent.fromMap(map);

      expect(recreatedEvent, equals(event));
    });

    test('toJson and fromJson work correctly', () {
      final event = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'JSON Event',
        description: 'JSON Description',
        location: 'JSON Location',
        mode: EventMode.normal,
        priority: EventPriority.medium,
        repeat: LunarRepeat.daily(),
        containTime: false,
        isEndOfMonth: false,
        createdDate: DateTime(2025, 5, 1),
      );

      final json = event.toJson();
      final recreatedEvent = LunarEvent.fromJson(json);

      expect(recreatedEvent, equals(event));
    });
  });
}
