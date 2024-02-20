import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:test/test.dart';

void main() {
  test('add', () {
    final now = DateTime.now();
    final future4Days = now.add(const Duration(days: 4));

    final lunarNow = now.toLunar;
    final lunarFuture4Days = lunarNow.add(const Duration(days: 4));

    expect(future4Days.toLunar, equals(lunarFuture4Days));
  });

  test('subtract', () {
    final now = DateTime.now();
    final past4Days = now.subtract(const Duration(days: 4));

    final lunarNow = now.toLunar;
    final lunarPast4Days = lunarNow.subtract(const Duration(days: 4));

    expect(past4Days.toLunar, equals(lunarPast4Days));
  });

  test('compareTo', () {
    final now = LunarDateTime.now();
    final past4Days = now.subtract(const Duration(days: 4));

    expect(now.compareTo(past4Days), greaterThan(0));
  });

  group('Events', () {
    test('LunarEvent', () {
      final event = LunarEvent(date: LunarDateTime.now(), title: 'test title');
      final json = event.toJson();

      final event1 =
          LunarEvent(date: LunarDateTime.now(), title: 'test 1 title');
      final json1 = event1.toJson();

      expect(LunarEvent.fromJson(json), equals(event));
      expect(LunarEvent.fromJson(json1), equals(event1));
    });

    test('LunarEventList', () {
      final events = LunarEventList(
        events: {
          LunarDateTime.now(): [
            LunarEvent(title: '', date: LunarDateTime.now())
          ]
        },
      );

      final json = events.toJson();

      final events1 = LunarEventList(
        events: {
          LunarDateTime.now(): [
            LunarEvent(title: '', date: LunarDateTime.now())
          ]
        },
      );
      final json1 = events.toJson();

      expect(LunarEventList.fromJson(json), equals(events));
      expect(LunarEventList.fromJson(json1), equals(events1));
    });
  });
}
