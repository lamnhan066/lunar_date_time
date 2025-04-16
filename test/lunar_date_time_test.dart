import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:test/test.dart';

void main() {
  LunarDateTime createLunarDateTime(DateTime dateTime) {
    return LunarDateTime.fromDateTime(dateTime);
  }

  group('LunarDateTime', () {
    test('add', () {
      final now = DateTime.now();
      final future4Days = now.add(const Duration(days: 4));

      final lunarFuture4Days = createLunarDateTime(future4Days);

      expect(future4Days.toLunar(), equals(lunarFuture4Days));
    });

    test('subtract', () {
      final now = DateTime.now();
      final past4Days = now.subtract(const Duration(days: 4));

      final lunarPast4Days = createLunarDateTime(past4Days);

      expect(past4Days.toLunar(), equals(lunarPast4Days));
    });

    test('compareTo', () {
      final now = createLunarDateTime(DateTime.now());
      final past4Days = createLunarDateTime(
          now.toDateTime().subtract(const Duration(days: 4)));

      expect(
          now.toDateTime().compareTo(past4Days.toDateTime()), greaterThan(0));
    });

    test('compareTo with equal times', () {
      final now = createLunarDateTime(DateTime.now());
      final nowCopy = createLunarDateTime(now.toDateTime());

      print(now);
      print(nowCopy);

      expect(now.toDateTime().compareTo(nowCopy.toDateTime()), equals(0));
    });
  });

  group('Events', () {
    test('LunarEvent equality', () {
      final event1 = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Festival',
        createdDate: DateTime(2025, 5, 1),
      );
      final event2 = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Festival',
        createdDate: DateTime(2025, 5, 1),
      );

      expect(event1, equals(event2));
    });

    test('SolarEvent equality', () {
      final event1 = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Solar Festival',
        createdDate: DateTime(2025, 5, 1),
      );
      final event2 = SolarEvent(
        date: SolarDateTime(2025, 5, 12),
        title: 'Solar Festival',
        createdDate: DateTime(2025, 5, 1),
      );

      expect(event1, equals(event2));
    });

    test('LunarEvent serialization', () {
      final event = LunarEvent(
        date: LunarDateTime(2025, 5, 12),
        title: 'Festival',
        createdDate: DateTime(2025, 5, 1),
      );

      final json = event.toJson();
      final deserializedEvent = LunarEvent.fromJson(json);

      expect(deserializedEvent, equals(event));
    });

    test('LunarEventList equality', () {
      final eventsList1 = LunarEventList(
        events: {
          LunarDateTime(2025, 5, 12): [
            LunarEvent(
                date: LunarDateTime(2025, 5, 12),
                title: 'Festival',
                createdDate: DateTime(2025, 5, 1)),
          ],
        },
      );
      final eventsList2 = LunarEventList(
        events: {
          LunarDateTime(2025, 5, 12): [
            LunarEvent(
                date: LunarDateTime(2025, 5, 12),
                title: 'Festival',
                createdDate: DateTime(2025, 5, 1)),
          ],
        },
      );

      expect(eventsList1, equals(eventsList2));
    });

    test('LunarEventList serialization', () {
      final eventsList = LunarEventList(
        events: {
          LunarDateTime(2025, 5, 12): [
            LunarEvent(
                date: LunarDateTime(2025, 5, 12),
                title: 'Festival',
                createdDate: DateTime(2025, 5, 1)),
          ],
        },
      );

      final json = eventsList.toJson();
      final deserializedList = LunarEventList.fromJson(json);

      expect(deserializedList, equals(eventsList));
    });
  });
}
