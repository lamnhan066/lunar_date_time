import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

bool _timezoneInitialized = false;
tz.Location? _utc7Location;

/// Initialize timezone to UTC+7 (Asia/Ho_Chi_Minh)
/// This should be called before using any timezone functions
Future<void> initializeTimezone() async {
  _initializeTimezoneSync();
}

/// Synchronously initialize timezone to UTC+7 (Asia/Ho_Chi_Minh)
/// This is safe to call multiple times
void _initializeTimezoneSync() {
  if (!_timezoneInitialized) {
    tz.initializeTimeZones();
    _utc7Location = tz.getLocation('Asia/Ho_Chi_Minh');
    _timezoneInitialized = true;
  }
}

/// Get the UTC+7 location (Asia/Ho_Chi_Minh)
/// This always returns UTC+7 regardless of device timezone
tz.Location get utc7 {
  _initializeTimezoneSync();
  return _utc7Location!;
}

/// Internal getter for UTC+7 location
tz.Location get _utc7 => utc7;

/// Get the current TZDateTime in UTC+7 timezone
/// This always returns UTC+7 time regardless of device timezone
tz.TZDateTime now() {
  _initializeTimezoneSync();
  return tz.TZDateTime.now(_utc7);
}

/// Create a TZDateTime in UTC+7 timezone from individual components
/// This always uses UTC+7 regardless of device timezone
tz.TZDateTime dateTime(
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
    _utc7,
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

/// Parse a DateTime string and convert it to UTC+7 timezone as TZDateTime
/// If the string doesn't contain timezone info, it's assumed to be in UTC+7
/// This always uses UTC+7 regardless of device timezone
tz.TZDateTime parse(String formattedString) {
  _initializeTimezoneSync();
  final parsed = DateTime.parse(formattedString);
  // If the parsed DateTime is already in UTC, convert it to UTC+7
  if (parsed.isUtc) {
    return tz.TZDateTime.from(parsed, _utc7);
  }
  // If it's local time, assume it's already in UTC+7 and convert
  return tz.TZDateTime.from(parsed, _utc7);
}

/// Convert a DateTime or TZDateTime to UTC+7 timezone as TZDateTime
/// If the TZDateTime is already in UTC+7, returns it as-is
/// This always uses UTC+7 regardless of device timezone
tz.TZDateTime toUtc7(dynamic dateTime) {
  _initializeTimezoneSync();
  if (dateTime is tz.TZDateTime) {
    if (dateTime.location == _utc7) {
      return dateTime;
    }
    return tz.TZDateTime.from(dateTime, _utc7);
  }
  return tz.TZDateTime.from(dateTime as DateTime, _utc7);
}

/// Get date only (00:00:00) as TZDateTime in UTC+7 timezone
/// Preserves TZDateTime type unlike DateUtils.dateOnly which returns DateTime
tz.TZDateTime dateOnly(dynamic dateTime) {
  _initializeTimezoneSync();
  final tzDateTime = dateTime is tz.TZDateTime ? dateTime : toUtc7(dateTime);
  return tz.TZDateTime(
    _utc7,
    tzDateTime.year,
    tzDateTime.month,
    tzDateTime.day,
  );
}
