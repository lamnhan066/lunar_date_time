import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:test/test.dart';

void main() {
  group('SolarEventList', () {
    late SolarEventList eventList;

    setUp(() {
      eventList = SolarEventList(events: {});
    });

    test('add adds an event to a specific date', () {
      final date = SolarDateTime(2025, 5, 12);
      final event = SolarEvent(
        date: date,
        title: 'Test Event',
        repeat: SolarRepeat.no(),
      );

      eventList.add(date, event);

      expect(eventList.getEvents(date), contains(event));
    });

    test('addAll adds multiple events to a specific date', () {
      final date = SolarDateTime(2025, 5, 12);
      final event1 = SolarEvent(
        date: date,
        title: 'Event 1',
        repeat: SolarRepeat.no(),
      );
      final event2 = SolarEvent(
        date: date,
        title: 'Event 2',
        repeat: SolarRepeat.no(),
      );

      eventList.addAll(date, [event1, event2]);

      expect(eventList.getEvents(date), containsAll([event1, event2]));
    });

    test('remove removes an event from a specific date', () {
      final date = SolarDateTime(2025, 5, 12);
      final event = SolarEvent(
        date: date,
        title: 'Test Event',
        repeat: SolarRepeat.no(),
      );

      eventList.add(date, event);
      final removed = eventList.remove(date, event);

      expect(removed, isTrue);
      expect(eventList.getEvents(date), isEmpty);
    });

    test('removeAll removes all events from a specific date', () {
      final date = SolarDateTime(2025, 5, 12);
      final event1 = SolarEvent(
        date: date,
        title: 'Event 1',
        repeat: SolarRepeat.no(),
      );
      final event2 = SolarEvent(
        date: date,
        title: 'Event 2',
        repeat: SolarRepeat.no(),
      );

      eventList.addAll(date, [event1, event2]);
      final removedEvents = eventList.removeAll(date);

      expect(removedEvents, containsAll([event1, event2]));
      expect(eventList.getEvents(date), isEmpty);
    });

    test('clear removes all events from the list', () {
      final date1 = SolarDateTime(2025, 5, 12);
      final date2 = SolarDateTime(2025, 5, 13);
      final event1 = SolarEvent(
        date: date1,
        title: 'Event 1',
        repeat: SolarRepeat.no(),
      );
      final event2 = SolarEvent(
        date: date2,
        title: 'Event 2',
        repeat: SolarRepeat.no(),
      );

      eventList.add(date1, event1);
      eventList.add(date2, event2);
      eventList.clear();

      expect(eventList.getEvents(date1), isEmpty);
      expect(eventList.getEvents(date2), isEmpty);
    });

    test('getEvents retrieves events for a specific date', () {
      final date = SolarDateTime(2025, 5, 12);
      final event = SolarEvent(
        date: date,
        title: 'Test Event',
        repeat: SolarRepeat.no(),
      );

      eventList.add(date, event);

      final events = eventList.getEvents(date);

      expect(events, contains(event));
    });

    test('toMap converts the event list to a map', () {
      final date = SolarDateTime(2025, 5, 12);
      final event = SolarEvent(
        date: date,
        title: 'Test Event',
        repeat: SolarRepeat.no(),
      );

      eventList.add(date, event);

      final map = eventList.toMap();

      expect(map['events'], isNotNull);
      expect(map['events'][date.toDateTime().toIso8601String()],
          contains(event.toJson()));
    });

    test('fromMap creates an event list from a map', () {
      final date = SolarDateTime(2025, 5, 12);
      final event = SolarEvent(
        date: date,
        title: 'Test Event',
        repeat: SolarRepeat.no(),
      );

      final map = {
        'events': {
          date.toDateTime().toIso8601String(): [event.toJson()]
        }
      };

      final recreatedEventList = SolarEventList.fromMap(map);
      final recreatedEvents = recreatedEventList.getEvents(date);

      expect(recreatedEvents.length, equals(1));
      expect(recreatedEvents[0].date, equals(event.date));
      expect(recreatedEvents[0].title, equals(event.title));
      expect(recreatedEvents[0].repeat.frequency, equals(event.repeat.frequency));
      expect(recreatedEvents[0].repeat.every, equals(event.repeat.every));
    });

    test('toJson and fromJson work correctly', () {
      final date = SolarDateTime(2025, 5, 12);
      final event = SolarEvent(
        date: date,
        title: 'Test Event',
        repeat: SolarRepeat.no(),
      );

      eventList.add(date, event);

      final json = eventList.toJson();
      final recreatedEventList = SolarEventList.fromJson(json);
      final recreatedEvents = recreatedEventList.getEvents(date);

      expect(recreatedEvents.length, equals(1));
      expect(recreatedEvents[0].date, equals(event.date));
      expect(recreatedEvents[0].title, equals(event.title));
      expect(recreatedEvents[0].repeat.frequency, equals(event.repeat.frequency));
      expect(recreatedEvents[0].repeat.every, equals(event.repeat.every));
    });

    test('toString returns a string representation of the event list', () {
      final date = SolarDateTime(2025, 5, 12);
      final event = SolarEvent(
        date: date,
        title: 'Test Event',
        repeat: SolarRepeat.no(),
      );

      eventList.add(date, event);

      final stringRepresentation = eventList.toString();

      expect(stringRepresentation, contains('SolarEventList'));
      expect(stringRepresentation, contains('events'));
    });
  });
}
