import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:test/test.dart';
import 'package:timezone/timezone.dart' as tz;

void main() {
  LunarDateTime createLunarDateTime(tz.TZDateTime dateTime) {
    return LunarDateTime.fromDateTime(dateTime);
  }

  group('LunarDateTime', () {
    test('add', () {
      final now = Utc7.now();
      final future4Days = now.add(const Duration(days: 4));

      final lunarFuture4Days = createLunarDateTime(future4Days);

      expect(future4Days.toLunar(), equals(lunarFuture4Days));
    });

    test('subtract', () {
      final now = Utc7.now();
      final past4Days = now.subtract(const Duration(days: 4));

      final lunarPast4Days = createLunarDateTime(past4Days);

      expect(past4Days.toLunar(), equals(lunarPast4Days));
    });

    test('compareTo', () {
      final now = createLunarDateTime(Utc7.now());
      final past4Days =
          createLunarDateTime(Utc7.now().subtract(const Duration(days: 4)));

      expect(
          now.toDateTime().compareTo(past4Days.toDateTime()), greaterThan(0));
    });

    test('compareTo with equal times', () {
      final now = createLunarDateTime(Utc7.now());
      final nowCopy = createLunarDateTime(Utc7.toUtc7(now.toDateTime()));

      print(now);
      print(nowCopy);

      expect(
          Utc7.toUtc7(now.toDateTime())
              .compareTo(Utc7.toUtc7(nowCopy.toDateTime())),
          equals(0));
    });
  });

  group('Events', () {
    test('LunarEvent equality', () {
      final event1 = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Festival',
        createdDate: Utc7.dateTime(2025, 5, 1),
      );
      final event2 = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Festival',
        createdDate: Utc7.dateTime(2025, 5, 1),
      );

      expect(event1, equals(event2));
    });

    test('SolarEvent equality', () {
      final event1 = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Solar Festival',
        createdDate: Utc7.dateTime(2025, 5, 1),
      );
      final event2 = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Solar Festival',
        createdDate: Utc7.dateTime(2025, 5, 1),
      );

      expect(event1, equals(event2));
    });

    test('LunarEvent serialization', () {
      final event = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Festival',
        createdDate: Utc7.dateTime(2025, 5, 1),
      );

      final json = event.toJson();
      final deserializedEvent = LunarEvent.fromJson(json);

      expect(deserializedEvent.date, equals(event.date));
      expect(deserializedEvent.title, equals(event.title));
      expect(
          deserializedEvent.repeat.frequency, equals(event.repeat.frequency));
      expect(deserializedEvent.repeat.every, equals(event.repeat.every));
    });
  });
}
