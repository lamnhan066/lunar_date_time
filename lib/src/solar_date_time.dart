import 'package:lunar_date_time/src/models/base_date_time.dart';

/// Lớp đại diện cho thời gian mặt trời (Solar DateTime)
/// với múi giờ cố định là UTC+7 (Indochina Time)
class SolarDateTime implements BaseDateTime {
  /// Đối tượng DateTime nội bộ đã được điều chỉnh theo UTC+7
  final DateTime _dateTime;

  /// Độ lệch múi giờ Indochina Time (UTC+7)
  static const Duration _fixedTimeZoneOffset = Duration(hours: 7);

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
  ]) : _dateTime = DateTime(
          year,
          month,
          day,
          hour,
          minute,
          second,
          millisecond,
          microsecond,
        );

  /// Hàm tạo từ một đối tượng DateTime
  /// Chuyển đổi DateTime sang múi giờ UTC+7
  factory SolarDateTime.fromDateTime(DateTime dateTime) {
    // DateTime sử dụng dữ liệu timezone lịch sử, điều này làm lệch ngày
    // đối với các mốc thời gian cũ (ví dụ năm 1969 tại Việt Nam từng là UTC+8).
    // Lịch cần cố định ở múi giờ UTC+7 nên ta bỏ qua offset lịch sử và giữ
    // nguyên giá trị ngày/giờ đã chọn.
    final local = dateTime.isUtc
        ? dateTime.add(_fixedTimeZoneOffset)
        : DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day,
            dateTime.hour,
            dateTime.minute,
            dateTime.second,
            dateTime.millisecond,
            dateTime.microsecond,
          );
    return SolarDateTime(
      local.year,
      local.month,
      local.day,
      local.hour,
      local.minute,
      local.second,
      local.millisecond,
      local.microsecond,
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
  DateTime toDateTime() {
    return DateTime(
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

  /// Chuyển đổi ngược lại sang đối tượng DateTime UTC
  @override
  DateTime toUtc() {
    final utc = _dateTime.subtract(_fixedTimeZoneOffset);
    return DateTime.utc(
      utc.year,
      utc.month,
      utc.day,
      utc.hour,
      utc.minute,
      utc.second,
      utc.millisecond,
      utc.microsecond,
    );
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
