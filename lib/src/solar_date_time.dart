import 'package:lunar_date_time/src/models/base_date_time.dart';
import 'package:lunar_date_time/src/timezone_utils.dart' as tz_utils;
import 'package:timezone/timezone.dart' as tz;

/// Lớp đại diện cho thời gian mặt trời (Solar DateTime)
/// với múi giờ cố định là UTC+7 (Indochina Time)
class SolarDateTime implements BaseDateTime {
  /// Đối tượng TZDateTime nội bộ đã được điều chỉnh theo UTC+7
  final tz.TZDateTime _dateTime;

  /// Hàm khởi tạo SolarDateTime với các tham số thời gian
  SolarDateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) : _dateTime = tz_utils.dateTime(
          year,
          month,
          day,
          hour,
          minute,
          second,
          millisecond,
          microsecond,
        );

  /// Hàm tạo từ một đối tượng TZDateTime hoặc DateTime
  /// Chuyển đổi sang múi giờ UTC+7
  factory SolarDateTime.fromDateTime(dynamic dateTime) {
    // Chuyển đổi DateTime hoặc TZDateTime sang TZDateTime trong UTC+7
    final utc7DateTime = tz_utils.toUtc7(dateTime);
    return SolarDateTime(
      utc7DateTime.year,
      utc7DateTime.month,
      utc7DateTime.day,
      utc7DateTime.hour,
      utc7DateTime.minute,
      utc7DateTime.second,
      utc7DateTime.millisecond,
      utc7DateTime.microsecond,
    );
  }

  /// Tạo một bản sao của [SolarDateTime] với các giá trị được thay đổi.
  @override
  SolarDateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return SolarDateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  @override
  tz.TZDateTime toDateTime() {
    return _dateTime;
  }

  /// Chuyển đổi ngược lại sang đối tượng TZDateTime UTC
  @override
  tz.TZDateTime toUtc() {
    return _dateTime.toUtc();
  }

  /// Lấy năm
  @override
  int get year => _dateTime.year;

  /// Lấy tháng
  @override
  int get month => _dateTime.month;

  /// Lấy ngày
  @override
  int get day => _dateTime.day;

  /// Lấy giờ
  @override
  int get hour => _dateTime.hour;

  /// Lấy phút
  @override
  int get minute => _dateTime.minute;

  /// Lấy giây
  @override
  int get second => _dateTime.second;

  /// Lấy mili giây
  @override
  int get millisecond => _dateTime.millisecond;

  /// Lấy micro giây
  @override
  int get microsecond => _dateTime.microsecond;

  /// Lấy ngày trong tuần
  @override
  int get weekday => _dateTime.weekday;

  /// So sánh hai đối tượng SolarDateTime
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SolarDateTime && _dateTime.isAtSameMomentAs(other._dateTime);

  /// Lấy mã băm (hash code)
  @override
  int get hashCode => _dateTime.hashCode;

  /// Chuyển đổi đối tượng thành chuỗi
  @override
  String toString() => 'SolarDateTime($_dateTime ICT)';
}
