import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:lunar_date_time/src/base.dart';
import 'package:lunar_date_time/src/can_chi.dart';
import 'package:lunar_date_time/src/converter.dart' as converter;
import 'package:lunar_date_time/src/events/lunar_events.dart';
import 'package:lunar_date_time/src/events/solar_events.dart';
import 'package:lunar_date_time/src/timezone_utils.dart' as tz_utils;
import 'package:timezone/timezone.dart' as tz;

class LunarDateTime extends BaseDateTime {
  /// Danh sách các ngày lễ âm lịch, được lưu trữ để tránh tính toán lại.
  static final LunarEventList _lunarEvents = getLunarEvents;
  static final List<LunarEvent> _lunarEventsAsList =
      List<LunarEvent>.from(_lunarEvents.events.values.expand((e) => e));

  /// Danh sách các ngày lễ dương lịch, được lưu trữ để tránh tính toán lại.
  static final SolarEventList _solarEvents = getSolarEvents;
  static final List<SolarEvent> _solarEventsAsList =
      List<SolarEvent>.from(_solarEvents.events.values.expand((e) => e));

  /// Trả về danh sách các ngày lễ âm lịch.
  static LunarEventList get lunarEvents => _lunarEvents;

  /// Trả về danh sách các ngày lễ âm lịch dưới dạng một danh sách phẳng.
  static List<LunarEvent> get lunarEventsAsList => _lunarEventsAsList;

  /// Trả về danh sách các ngày lễ dương lịch.
  static SolarEventList get solarEvents => _solarEvents;

  /// Trả về danh sách các ngày lễ dương lịch dưới dạng một danh sách phẳng.
  static List<SolarEvent> get solarEventsAsList => _solarEventsAsList;

  /// Constructor nội bộ, được sử dụng để khởi tạo đối tượng LunarDateTime.
  LunarDateTime._internal({
    required SolarDateTime solarDateTime,
    required this.year,
    this.month = 1,
    this.day = 1,
    this.hour = 0,
    this.minute = 0,
    this.second = 0,
    this.millisecond = 0,
    this.microsecond = 0,
    required this.isLeapMonth,
  }) : _solarDateTime = solarDateTime;

  /// Constructor chính, khởi tạo LunarDateTime từ năm, tháng, ngày và các thông tin khác.
  factory LunarDateTime(
    int year, [
    int month = 1,
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) {
    final solar = converter.convertLunar2Solar(
      day,
      month,
      year,
      0,
      7,
    );
    return LunarDateTime._internal(
      solarDateTime: SolarDateTime.fromDateTime(
        tz_utils.dateTime(
          solar.year,
          solar.month,
          solar.day,
          hour,
          minute,
          second,
          millisecond,
          microsecond,
        ),
      ),
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      millisecond: millisecond,
      microsecond: microsecond,
      isLeapMonth: false,
    );
  }

  /// Constructor cho tháng nhuận.
  factory LunarDateTime.leapMonth(
    int year,
    int month, [
    int day = 1,
    int hour = 0,
    int minute = 0,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) {
    final solar = converter.convertLunar2Solar(
      day,
      month,
      year,
      1,
      7,
    );
    return LunarDateTime._internal(
      solarDateTime: SolarDateTime.fromDateTime(
        tz_utils.dateTime(
          solar.year,
          solar.month,
          solar.day,
          hour,
          minute,
          second,
          millisecond,
          microsecond,
        ),
      ),
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      millisecond: millisecond,
      microsecond: microsecond,
      isLeapMonth: true,
    );
  }

  /// Constructor khởi tạo từ đối tượng TZDateTime hoặc DateTime.
  /// Converts to UTC+7 timezone before processing.
  factory LunarDateTime.fromDateTime(dynamic dateTime) {
    // Ensure the DateTime/TZDateTime is in UTC+7 timezone
    final utc7DateTime = tz_utils.toUtc7(dateTime);
    final solar = SolarDateTime.fromDateTime(utc7DateTime);
    final lunar = converter.convertSolar2Lunar(
      solar.day,
      solar.month,
      solar.year,
      7.0,
    );
    return LunarDateTime._internal(
      solarDateTime: solar,
      year: lunar.year,
      month: lunar.month,
      day: lunar.day,
      hour: solar.hour,
      minute: solar.minute,
      second: solar.second,
      millisecond: solar.millisecond,
      microsecond: solar.microsecond,
      isLeapMonth: lunar.isLeapMonth,
    );
  }

  /// Tạo một bản sao của [LunarDateTime] với các giá trị được thay đổi.
  @override
  LunarDateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
    bool? isLeapMonth,
  }) {
    return isLeapMonth ?? this.isLeapMonth
        ? LunarDateTime.leapMonth(
            year ?? this.year,
            month ?? this.month,
            day ?? this.day,
            hour ?? this.hour,
            minute ?? this.minute,
            second ?? this.second,
            millisecond ?? this.millisecond,
            microsecond ?? this.microsecond,
          )
        : LunarDateTime(
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
  int year;
  @override
  int month;
  @override
  int day;
  @override
  int hour;
  @override
  int minute;
  @override
  int second;
  @override
  int millisecond;
  @override
  int microsecond;

  @override
  int get weekday => _solarDateTime.weekday;

  /// Đối tượng SolarDateTime tương ứng với LunarDateTime.
  final SolarDateTime _solarDateTime;

  /// `true` nếu tháng hiện tại là tháng nhuận.
  final bool isLeapMonth;

  /// Số ngày Julian cho ngày hiện tại.
  int get julianDayNumber {
    final solar = toSolar();
    return jdFromDate(solar.day, solar.month, solar.year);
  }

  /// Can chi của năm hiện tại.
  String get stemBranchOfYear => getCanChiOfYear(year);

  /// Can chi của tháng hiện tại.
  String get stemBranchOfMonth => getCanChiMonth(month, year);

  /// Can của giờ hiện tại.
  String get stemOfHour => getCanOfHour(julianDayNumber);

  /// Can chi của ngày hiện tại.
  String get stemBranchOfDay => getCanChiOfDay(julianDayNumber);

  /// Giờ hoàng đạo của ngày hiện tại.
  String get luckyHour => getLuckyHour(julianDayNumber);

  /// Tiết khí của ngày hiện tại.
  String get solarTerms => getSolarTerms(julianDayNumber);

  /// Chuyển đổi [LunarDateTime] thành [SolarDateTime].
  SolarDateTime toSolar() {
    return _solarDateTime;
  }

  @override
  tz.TZDateTime toDateTime() {
    return _solarDateTime.toDateTime();
  }

  @override
  tz.TZDateTime toUtc() {
    return _solarDateTime.toUtc();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LunarDateTime && _solarDateTime == other._solarDateTime;
  }

  @override
  int get hashCode => _solarDateTime.hashCode;

  @override
  String toString() {
    return 'LunarDateTime(year: $year, month: $month, day: $day, hour: $hour, minute: $minute, second: $second, millisecond: $millisecond, microsecond: $microsecond, _solarDateTime: $_solarDateTime, isLeapMonth: $isLeapMonth)';
  }
}
