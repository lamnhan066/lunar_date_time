import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Utility class for working with UTC+7 timezone (Asia/Ho_Chi_Minh)
/// This class provides static methods to work with timezone operations
/// that always use UTC+7 regardless of device timezone
class Utc7 {
  static bool _timezoneInitialized = false;
  static late tz.Location _utc7Location;

  /// Synchronously initialize timezone to UTC+7 (Asia/Ho_Chi_Minh)
  /// This is safe to call multiple times
  static void _initializeTimezoneSync() {
    if (!_timezoneInitialized) {
      tz.initializeTimeZones();
      _utc7Location = tz.getLocation('Asia/Ho_Chi_Minh');
      _timezoneInitialized = true;
    }
  }

  /// Get the UTC+7 location (Asia/Ho_Chi_Minh)
  /// This always returns UTC+7 regardless of device timezone
  static tz.Location get location {
    _initializeTimezoneSync();
    return _utc7Location;
  }

  /// Get the current TZDateTime in UTC+7 timezone
  /// This always returns UTC+7 time regardless of device timezone
  static tz.TZDateTime now() {
    _initializeTimezoneSync();
    return tz.TZDateTime.now(_utc7Location);
  }

  /// Create a TZDateTime in UTC+7 timezone from individual components
  /// This always uses UTC+7 regardless of device timezone
  static tz.TZDateTime dateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) {
    _initializeTimezoneSync();
    return tz.TZDateTime(
      _utc7Location,
      year,
      month,
      day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  /// Parse a TZDateTime string and convert it to UTC+7 timezone as TZDateTime
  /// If the string doesn't contain timezone info, it's assumed to be in UTC+7
  /// This always uses UTC+7 regardless of device timezone
  static tz.TZDateTime parse(String formattedString) {
    _initializeTimezoneSync();
    // Parse the string and convert to TZDateTime in UTC+7
    final parsed = DateTime.parse(formattedString);
    return tz.TZDateTime.from(parsed, _utc7Location);
  }

  /// Converts any [DateTime] (local, UTC, or TZDateTime) to a [tz.TZDateTime]
  /// in the UTC+7 timezone (Asia/Ho_Chi_Minh).
  ///
  /// If the input is already a [tz.TZDateTime] in UTC+7, it is returned unchanged.
  ///
  /// Regardless of the input's original timezone, the result is always in UTC+7.
  static tz.TZDateTime toUtc7(DateTime dateTime) {
    _initializeTimezoneSync();
    return tz.TZDateTime.from(dateTime, _utc7Location);
  }

  /// Create a TZDateTime from milliseconds since epoch in UTC+7 timezone
  static tz.TZDateTime fromMillisecondsSinceEpoch(int millisecondsSinceEpoch) {
    _initializeTimezoneSync();
    final utc = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch,
        isUtc: true);
    return tz.TZDateTime.from(utc, _utc7Location);
  }

  /// Get date only (00:00:00) as TZDateTime in UTC+7 timezone
  static tz.TZDateTime dateOnly(tz.TZDateTime dateTime) {
    _initializeTimezoneSync();
    final tzDateTime = toUtc7(dateTime);
    return tz.TZDateTime(
      _utc7Location,
      tzDateTime.year,
      tzDateTime.month,
      tzDateTime.day,
    );
  }
}
