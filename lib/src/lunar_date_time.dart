import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:lunar_date_time/src/base.dart';
import 'package:lunar_date_time/src/can_chi.dart';
import 'package:lunar_date_time/src/converter.dart';
import 'package:lunar_date_time/src/events/lunar_events.dart';
import 'package:lunar_date_time/src/events/solar_events.dart';

class LunarDateTime extends DateTime {
  /// Force the timezone offset to +7 hours (Indochina Time, ICT).
  static const Duration _fixedTimeZoneOffset = Duration(hours: 7);

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

  /// Tạo một đối tượng [LunarDateTime] từ một đối tượng [DateTime].
  factory LunarDateTime.fromDateTime(DateTime dateTime) {
    // Adjust the DateTime to the fixed +7 timezone.
    final adjustedDateTime = dateTime.add(_fixedTimeZoneOffset);

    final lunarDate = convertSolar2Lunar(
      adjustedDateTime.day,
      adjustedDateTime.month,
      adjustedDateTime.year,
      _fixedTimeZoneOffset.inHours.toDouble(),
    );

    return LunarDateTime._internal(
      lunarDate.year,
      lunarDate.month,
      lunarDate.day,
      adjustedDateTime.hour,
      adjustedDateTime.minute,
      adjustedDateTime.second,
      adjustedDateTime.millisecond,
      adjustedDateTime.microsecond,
      lunarDate.isLeapMonth,
      adjustedDateTime,
    );
  }

  /// Tạo một đối tượng [LunarDateTime] cho thời điểm hiện tại.
  factory LunarDateTime.now() {
    // Force the current time to use the +7 timezone.
    final now = DateTime.now().toUtc().add(_fixedTimeZoneOffset);
    return LunarDateTime.fromDateTime(now);
  }

  /// Tạo một đối tượng [LunarDateTime] từ số mili giây kể từ thời điểm Unix epoch.
  factory LunarDateTime.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
          {bool isUtc = false}) =>
      LunarDateTime.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch,
            isUtc: isUtc),
      );

  /// Tạo một đối tượng [LunarDateTime] từ số micro giây kể từ thời điểm Unix epoch.
  factory LunarDateTime.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch,
          {bool isUtc = false}) =>
      LunarDateTime.fromDateTime(
        DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch,
            isUtc: isUtc),
      );

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
  ])  : isLeapMonth = false,
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
    this._dateTime,
  ]) : super(year, month, day, hour, minute, second, millisecond, microsecond);

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
  ])  : isLeapMonth = true,
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
  DateTime toDateTime() {
    if (_dateTime != null) {
      return _dateTime!;
    }

    final solar = convertLunar2Solar(
      day,
      month,
      year,
      isLeapMonth ? 1 : 0,
      _fixedTimeZoneOffset.inHours.toDouble(),
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
  bool get isUtc => false; // Always false since we're forcing +7 timezone.

  @override
  int get microsecondsSinceEpoch => toDateTime().microsecondsSinceEpoch;

  @override
  int get millisecondsSinceEpoch => toDateTime().millisecondsSinceEpoch;

  @override
  String get timeZoneName => 'ICT'; // Indochina Time.

  @override
  Duration get timeZoneOffset => _fixedTimeZoneOffset;

  @override
  String toIso8601String() {
    return toDateTime().toIso8601String();
  }

  @override
  @Deprecated(
      'LunarDateTime does not support local conversion. Use toDateTime() instead.')
  DateTime toLocal() {
    throw UnimplementedError(
        'LunarDateTime does not support local conversion.');
  }

  @override
  @Deprecated(
      'LunarDateTime does not support UTC conversion. Use toDateTime() instead.')
  DateTime toUtc() {
    throw UnimplementedError('LunarDateTime does not support UTC conversion.');
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
        other.millisecond == millisecond &&
        other.microsecond == microsecond;
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
        millisecond,
        microsecond,
      );

  @override
  String toString() {
    return toDateTime().toString();
  }
}
