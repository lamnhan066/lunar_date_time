import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:test/test.dart';

void main() {
  group('SolarEvent', () {
    test('fromBaseEvent creates a SolarEvent from a BaseEvent', () {
      final baseEvent = SolarEvent(
        id: '1',
        date: SolarDateTime(2025, 5, 12),
        title: 'Base Event',
        description: 'Base Event Description',
        location: 'Base Location',
        mode: EventMode.normal,
        priority: EventPriority.high,
        repeat: SolarRepeat.daily(),
        containTime: true,
        isEndOfMonth: false,
        createdDate: DateTime(2025, 5, 1),
      );

      final solarEvent = SolarEvent.fromBaseEvent(baseEvent);

      expect(solarEvent.id, equals(baseEvent.id));
      expect(solarEvent.date, equals(baseEvent.date));
      expect(solarEvent.title, equals(baseEvent.title));
      expect(solarEvent.description, equals(baseEvent.description));
      expect(solarEvent.location, equals(baseEvent.location));
      expect(solarEvent.mode, equals(baseEvent.mode));
      expect(solarEvent.priority, equals(baseEvent.priority));
      expect(solarEvent.repeat, isA<SolarRepeat>());
      expect(solarEvent.containTime, equals(baseEvent.containTime));
      expect(solarEvent.isEndOfMonth, equals(baseEvent.isEndOfMonth));
      expect(solarEvent.createdDate, equals(baseEvent.createdDate));
    });

    test('copyWith creates a copy with updated values', () {
      final event = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Original Event',
        description: 'Original Description',
        location: 'Original Location',
        mode: EventMode.normal,
        priority: EventPriority.medium,
        repeat: SolarRepeat.daily(),
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
      final event = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Non-Repeating Event',
        repeat: SolarRepeat.no(),
      );

      expect(event.checkDate(SolarDateTime(2025, 5, 12)), isTrue);
      expect(event.checkDate(SolarDateTime(2025, 5, 13)), isFalse);
    });

    test('checkDate validates daily repeating event correctly', () {
      final event = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Daily Event',
        repeat: SolarRepeat.daily(),
      );

      expect(event.checkDate(SolarDateTime(2025, 5, 12)), isTrue);
      expect(event.checkDate(SolarDateTime(2025, 5, 13)), isTrue);
      expect(event.checkDate(SolarDateTime(2025, 5, 14)), isTrue);
    });

    test('checkDate validates weekly repeating event correctly', () {
      final event = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Weekly Event',
        repeat: SolarRepeat.weekly(),
      );

      expect(event.checkDate(SolarDateTime(2025, 5, 19)), isTrue);
      expect(event.checkDate(SolarDateTime(2025, 5, 26)), isTrue);
      expect(event.checkDate(SolarDateTime(2025, 5, 13)), isFalse);
    });

    test('checkDate validates monthly repeating event correctly', () {
      final event = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Monthly Event',
        repeat: SolarRepeat.monthly(),
      );

      expect(event.checkDate(SolarDateTime(2025, 6, 12)), isTrue);
      expect(event.checkDate(SolarDateTime(2025, 7, 12)), isTrue);
      expect(event.checkDate(SolarDateTime(2025, 6, 13)), isFalse);
    });

    test('checkDate validates yearly repeating event correctly', () {
      final event = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Yearly Event',
        repeat: SolarRepeat.yearly(),
      );

      expect(event.checkDate(SolarDateTime(2026, 5, 12)), isTrue);
      expect(event.checkDate(SolarDateTime(2027, 5, 12)), isTrue);
      expect(event.checkDate(SolarDateTime(2026, 5, 13)), isFalse);
    });

    test('toMap and fromMap work correctly', () {
      final event = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Mapped Event',
        description: 'Mapped Description',
        location: 'Mapped Location',
        mode: EventMode.normal,
        priority: EventPriority.medium,
        repeat: SolarRepeat.daily(),
        containTime: false,
        isEndOfMonth: false,
        createdDate: DateTime(2025, 5, 1),
      );

      final map = event.toMap();
      final recreatedEvent = SolarEvent.fromMap(map);

      expect(recreatedEvent, equals(event));
    });

    test('toJson and fromJson work correctly', () {
      final event = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'JSON Event',
        description: 'JSON Description',
        location: 'JSON Location',
        mode: EventMode.normal,
        priority: EventPriority.medium,
        repeat: SolarRepeat.daily(),
        containTime: false,
        isEndOfMonth: false,
        createdDate: DateTime(2025, 5, 1),
      );

      final json = event.toJson();
      final recreatedEvent = SolarEvent.fromJson(json);

      expect(recreatedEvent, equals(event));
    });
  });
}
