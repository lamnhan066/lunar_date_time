import 'package:timezone/timezone.dart' as tz;

/// Lớp trừu tượng BaseDateTime đại diện cho một đối tượng thời gian cơ bản.
abstract class BaseDateTime {
  BaseDateTime();

  /// Lấy năm.
  int get year;

  /// Lấy tháng.
  int get month;

  /// Lấy ngày.
  int get day;

  /// Lấy giờ.
  int get hour;

  /// Lấy phút.
  int get minute;

  /// Lấy giây.
  int get second;

  /// Lấy mili giây.
  int get millisecond;

  /// Lấy micro giây.
  int get microsecond;

  /// Lấy ngày trong tuần (1: Thứ hai, 7: Chủ nhật).
  int get weekday;

  /// Chuyển đổi đối tượng BaseDateTime thành đối tượng TZDateTime.
  tz.TZDateTime toDateTime();

  /// Chuyển đổi đối tượng BaseDateTime thành đối tượng TZDateTime UTC.
  tz.TZDateTime toUtc();

  BaseDateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  });
}
