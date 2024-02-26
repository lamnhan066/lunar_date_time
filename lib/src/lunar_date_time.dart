import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:lunar_date_time/src/base.dart';
import 'package:lunar_date_time/src/can_chi.dart';
import 'package:lunar_date_time/src/converter.dart';
import 'package:lunar_date_time/src/events/lunar_events.dart';
import 'package:lunar_date_time/src/events/solar_events.dart';

class LunarDateTime extends DateTime {
  /// Danh sách các ngày lễ âm lịch, thời gian ở đây sẽ sử dụng [LunarDateTime].
  static LunarEventList get lunarEvents => getLunarEvents;

  static List<LunarEvent> get lunarEventsAsList => getLunarEventsAsList;

  /// Danh sách các ngày lễ dương lịch, thời gian ở đây sẽ sử dụng [DateTime].
  static SolarEventList get solarEvents => getSolarEvents;

  static List<SolarEvent> get solarEventsAsList => getSolarEventsAsList;

  static LunarDateTime parse(String formattedString) {
    return LunarDateTime.fromDateTime(DateTime.parse(formattedString));
  }

  static LunarDateTime? tryParse(String formattedString) {
    final parsed = DateTime.tryParse(formattedString);
    return parsed == null ? null : LunarDateTime.fromDateTime(parsed);
  }

  /// Nếu `true` thí tháng hiện tại là tháng nhuần
  final bool isLeapMonth;

  @override
  final int day;
  @override
  final int hour;
  @override
  final int microsecond;
  @override
  final int millisecond;
  @override
  final int minute;
  @override
  final int month;
  @override
  final int second;
  @override
  final int year;

  DateTime? _dateTime;

  /// Giá trị ngày Julian.
  int get julianDayNumber {
    final solar = toDateTime();
    return jdFromDate(solar.day, solar.month, solar.year);
  }

  /// Can chi của năm hiện tại.
  String get canChiOfYear => getCanChiOfYear(year);

  /// Can chi của tháng hiện tại.
  String get canChiOfMonth => getCanChiMonth(month, year);

  /// Can của giờ hiện tại.
  String get canOfHour => getCanOfHour(julianDayNumber);

  /// Can chi của ngày hiện tại.
  String get canChiOfDay => getCanChiOfDay(julianDayNumber);

  /// Giờ hoàng đạo.
  String get luckyHour => getLuckyHour(julianDayNumber);

  /// Tiết khí.
  String get solarTerms => getSolarTerms(julianDayNumber);

  /// Lưu [timeZoneOffset] khi chuyển từ [DateTime], đồng
  Duration _timeZoneOffset;

  LunarDateTime._(
    this.year, [
    this.month = 1,
    this.day = 1,
    this.hour = 0,
    this.minute = 0,
    this.second = 0,
    this.millisecond = 0,
    this.microsecond = 0,
    this.isLeapMonth = false,
    Duration? timeZoneOffset,
    this._dateTime,
  ])  : _timeZoneOffset = timeZoneOffset ?? DateTime.now().timeZoneOffset,
        super(year, month, day, hour, minute, second, millisecond, microsecond);

  LunarDateTime(
    this.year, [
    this.month = 1,
    this.day = 1,
    this.hour = 0,
    this.minute = 0,
    this.second = 0,
    this.millisecond = 0,
    this.microsecond = 0,
  ])  : _timeZoneOffset = DateTime.now().timeZoneOffset,
        isLeapMonth = false,
        _dateTime = null,
        super(year, month, day, hour, minute, second, millisecond, microsecond);

  LunarDateTime.leapMonth(
    this.year, [
    this.month = 1,
    this.day = 1,
    this.hour = 0,
    this.minute = 0,
    this.second = 0,
    this.millisecond = 0,
    this.microsecond = 0,
  ])  : _timeZoneOffset = DateTime.now().timeZoneOffset,
        isLeapMonth = true,
        _dateTime = null,
        super(year, month, day, hour, minute, second, millisecond, microsecond);

  factory LunarDateTime.fromDateTime(DateTime dateTime) {
    final lunarDate = convertSolar2Lunar(
      dateTime.day,
      dateTime.month,
      dateTime.year,
      dateTime.timeZoneOffset.inMilliseconds / (1000.0 * 60.0 * 60.0),
    );

    return LunarDateTime._(
      lunarDate.year,
      lunarDate.month,
      lunarDate.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond,
      lunarDate.isLeapMonth,
      dateTime.timeZoneOffset,
      dateTime,
    );
  }

  factory LunarDateTime.now() => LunarDateTime.fromDateTime(DateTime.now());

  factory LunarDateTime.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
          {bool isUtc = false}) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: isUtc)
          .toLunar;

  factory LunarDateTime.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch,
          {bool isUtc = false}) =>
      DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch, isUtc: isUtc)
          .toLunar;

  LunarDateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
    bool? leapMonth,
  }) {
    return ((leapMonth ?? isLeapMonth)
        ? LunarDateTime.leapMonth
        : LunarDateTime.new)(
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

  /// Chuyển đổi từ [LunarDateTime] sang [DateTime] với tham số [timeZoneOffset]
  /// là độ chênh lệch giữa Local và UTC, mặc định sẽ sử dụng giá trị từ
  /// [DateTime.now].
  DateTime toDateTime([Duration? timeZoneOffset]) {
    if (_dateTime != null && _timeZoneOffset == timeZoneOffset) {
      return _dateTime!;
    }

    timeZoneOffset ??= this.timeZoneOffset;
    final solar = convertLunar2Solar(
      day,
      month,
      year,
      isLeapMonth == true ? 1 : 0,
      timeZoneOffset.inMilliseconds / (1000.0 * 60.0 * 60.0),
    );

    final dateTime0 = DateTime(
      solar.year,
      solar.month,
      solar.day,
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );

    if (_timeZoneOffset == timeZoneOffset) {
      _dateTime = dateTime0;
    }
    return dateTime0;
  }

  @override
  LunarDateTime add(Duration duration) {
    return LunarDateTime.fromDateTime(toDateTime().add(duration));
  }

  @override
  LunarDateTime subtract(Duration duration) {
    return LunarDateTime.fromDateTime(toDateTime().subtract(duration));
  }

  @override
  int compareTo(covariant LunarDateTime other) {
    return toDateTime().compareTo(other.toDateTime());
  }

  @override
  Duration difference(covariant LunarDateTime other) {
    return toDateTime().difference(other.toDateTime());
  }

  @override
  bool isAfter(covariant LunarDateTime other) {
    return toDateTime().isAfter(other.toDateTime());
  }

  @override
  bool isAtSameMomentAs(covariant LunarDateTime other) {
    return toDateTime().isAtSameMomentAs(other.toDateTime());
  }

  @override
  bool isBefore(covariant LunarDateTime other) {
    return toDateTime().isBefore(other.toDateTime());
  }

  @override
  bool get isUtc => toDateTime().isUtc;

  @override
  int get microsecondsSinceEpoch => toDateTime().microsecondsSinceEpoch;

  @override
  int get millisecondsSinceEpoch => toDateTime().millisecondsSinceEpoch;

  @override
  String get timeZoneName => toDateTime().timeZoneName;

  @override
  Duration get timeZoneOffset => _timeZoneOffset;

  @override
  String toIso8601String() {
    return toDateTime().toIso8601String();
  }

  @override
  DateTime toLocal() {
    return toDateTime().toLocal();
  }

  @override
  DateTime toUtc() {
    return toDateTime().toUtc();
  }

  @override
  int get weekday => toDateTime().weekday;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LunarDateTime &&
        other.isLeapMonth == isLeapMonth &&
        other.year == year &&
        other.month == month &&
        other.day == day &&
        other.hour == hour &&
        other.minute == minute &&
        other.second == second &&
        other._timeZoneOffset == _timeZoneOffset;
  }

  @override
  int get hashCode {
    return isLeapMonth.hashCode ^
        year.hashCode ^
        month.hashCode ^
        day.hashCode ^
        hour.hashCode ^
        minute.hashCode ^
        second.hashCode ^
        _timeZoneOffset.hashCode;
  }

  @override
  String toString() {
    return toDateTime().toString();
  }
}
