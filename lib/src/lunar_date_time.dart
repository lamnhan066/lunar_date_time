import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:lunar_date_time/src/base.dart';
import 'package:lunar_date_time/src/can_chi.dart';
import 'package:lunar_date_time/src/converter.dart';
import 'package:lunar_date_time/src/events/lunar_events.dart';
import 'package:lunar_date_time/src/events/solar_events.dart';

class LunarDateTime extends DateTime {
  /// Danh sách các ngày lễ âm lịch, được lưu trữ để tránh tính toán lại.
  static final LunarEventList _lunarEvents = getLunarEvents;
  static final List<LunarEvent> _lunarEventsAsList =
      _lunarEvents.events.values.expand((e) => e).toList();

  /// Danh sách các ngày lễ dương lịch, được lưu trữ để tránh tính toán lại.
  static final SolarEventList _solarEvents = getSolarEvents;
  static final List<SolarEvent> _solarEventsAsList =
      _solarEvents.events.values.expand((e) => e).toList();

  /// Trả về danh sách các ngày lễ âm lịch.
  static LunarEventList get lunarEvents => _lunarEvents;

  /// Trả về danh sách các ngày lễ âm lịch dưới dạng một danh sách phẳng.
  static List<LunarEvent> get lunarEventsAsList => _lunarEventsAsList;

  /// Trả về danh sách các ngày lễ dương lịch.
  static SolarEventList get solarEvents => _solarEvents;

  /// Trả về danh sách các ngày lễ dương lịch dưới dạng một danh sách phẳng.
  static List<SolarEvent> get solarEventsAsList => _solarEventsAsList;

  /// Phân tích một chuỗi thành đối tượng [LunarDateTime].
  static LunarDateTime parse(String formattedString) {
    return LunarDateTime.fromDateTime(DateTime.parse(formattedString));
  }

  /// Cố gắng phân tích một chuỗi thành đối tượng [LunarDateTime].
  /// Trả về `null` nếu không thể phân tích.
  static LunarDateTime? tryParse(String formattedString) {
    final parsed = DateTime.tryParse(formattedString);
    return parsed == null ? null : LunarDateTime.fromDateTime(parsed);
  }

  /// `true` nếu tháng hiện tại là tháng nhuận.
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
  Duration _timeZoneOffset;

  /// Tạo một đối tượng [LunarDateTime] từ một đối tượng [DateTime].
  factory LunarDateTime.fromDateTime(DateTime dateTime) {
    final lunarDate = convertSolar2Lunar(
      dateTime.day,
      dateTime.month,
      dateTime.year,
      dateTime.timeZoneOffset.inMilliseconds / (1000.0 * 60.0 * 60.0),
    );

    return LunarDateTime._internal(
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

  /// Tạo một đối tượng [LunarDateTime] cho thời điểm hiện tại.
  factory LunarDateTime.now() => LunarDateTime.fromDateTime(DateTime.now());

  /// Tạo một đối tượng [LunarDateTime] từ số mili giây kể từ thời điểm Unix epoch.
  factory LunarDateTime.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
          {bool isUtc = false}) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: isUtc)
          .toLunar;

  /// Tạo một đối tượng [LunarDateTime] từ số micro giây kể từ thời điểm Unix epoch.
  factory LunarDateTime.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch,
          {bool isUtc = false}) =>
      DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch, isUtc: isUtc)
          .toLunar;

  /// Constructor chính cho [LunarDateTime].
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

  /// Constructor nội bộ cho [LunarDateTime].
  LunarDateTime._internal(
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
        super(
            year, month, day, hour, minute, second, millisecond, microsecond) {
    assert(year > 0, 'Năm phải là số dương');
    assert(
        month >= 1 && month <= 12, 'Tháng phải nằm trong khoảng từ 1 đến 12');
    assert(day >= 1 && day <= 31, 'Ngày phải nằm trong khoảng từ 1 đến 31');
    assert(hour >= 0 && hour < 24, 'Giờ phải nằm trong khoảng từ 0 đến 23');
    assert(
        minute >= 0 && minute < 60, 'Phút phải nằm trong khoảng từ 0 đến 59');
    assert(
        second >= 0 && second < 60, 'Giây phải nằm trong khoảng từ 0 đến 59');
  }

  /// Tạo một đối tượng [LunarDateTime] cho tháng nhuận.
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

  /// Số ngày Julian cho ngày hiện tại.
  int get julianDayNumber {
    final solar = toDateTime();
    return jdFromDate(solar.day, solar.month, solar.year);
  }

  /// Can chi của năm hiện tại.
  @Deprecated('Sử dụng `stemBranchOfYear`')
  String get canChiOfYear => getCanChiOfYear(year);

  /// Can chi của tháng hiện tại.
  @Deprecated('Sử dụng `stemBranchOfMonth`')
  String get canChiOfMonth => getCanChiMonth(month, year);

  /// Can của giờ hiện tại.
  @Deprecated('Sử dụng `stemOfHour`')
  String get canOfHour => getCanOfHour(julianDayNumber);

  /// Can chi của ngày hiện tại.
  @Deprecated('Sử dụng `stemBranchOfDay`')
  String get canChiOfDay => getCanChiOfDay(julianDayNumber);

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

  /// Chuyển đổi [LunarDateTime] thành [DateTime].
  DateTime toDateTime([Duration? timeZoneOffset]) {
    timeZoneOffset ??= this.timeZoneOffset;

    if (_dateTime != null && _timeZoneOffset == timeZoneOffset) {
      return _dateTime!;
    }

    final solar = convertLunar2Solar(
      day,
      month,
      year,
      isLeapMonth ? 1 : 0,
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

    _dateTime = dateTime0;
    _timeZoneOffset = timeZoneOffset;

    return dateTime0;
  }

  /// Tạo một bản sao của [LunarDateTime] với các trường được cập nhật.
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
    return LunarDateTime._internal(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
      isLeapMonth ?? this.isLeapMonth,
      _timeZoneOffset,
      _dateTime,
    );
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
  int get hashCode => Object.hash(
        isLeapMonth,
        year,
        month,
        day,
        hour,
        minute,
        second,
        _timeZoneOffset,
      );

  @override
  String toString() {
    return toDateTime().toString();
  }
}
