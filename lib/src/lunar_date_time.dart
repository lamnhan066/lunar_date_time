import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:lunar_date_time/src/base.dart';
import 'package:lunar_date_time/src/can_chi.dart';
import 'package:lunar_date_time/src/converter.dart';
import 'package:lunar_date_time/src/events/lunar_events.dart';
import 'package:lunar_date_time/src/events/solar_events.dart';

class LunarDateTime {
  /// Force the timezone offset to +7 hours (Indochina Time, ICT).
  static const Duration _fixedTimeZoneOffset = Duration(hours: 7);

  /// Danh sách các ngày lễ âm lịch, được lưu trữ để tránh tính toán lại.
  static final LunarEventList _lunarEvents = getLunarEvents;
  static final List<BaseEvent<LunarDateTime>> _lunarEventsAsList =
      _lunarEvents.events.values.expand((e) => e).toList();

  /// Danh sách các ngày lễ dương lịch, được lưu trữ để tránh tính toán lại.
  static final SolarEventList _solarEvents = getSolarEvents;
  static final List<BaseEvent<DateTime>> _solarEventsAsList =
      _solarEvents.events.values.expand((e) => e).toList();

  /// Trả về danh sách các ngày lễ âm lịch.
  static LunarEventList get lunarEvents => _lunarEvents;

  /// Trả về danh sách các ngày lễ âm lịch dưới dạng một danh sách phẳng.
  static List<BaseEvent<LunarDateTime>> get lunarEventsAsList =>
      _lunarEventsAsList;

  /// Trả về danh sách các ngày lễ dương lịch.
  static SolarEventList get solarEvents => _solarEvents;

  /// Trả về danh sách các ngày lễ dương lịch dưới dạng một danh sách phẳng.
  static List<BaseEvent<DateTime>> get solarEventsAsList => _solarEventsAsList;

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

  /// Phân tích một chuỗi theo định dạng âm lịch thành đối tượng [LunarDateTime].
  /// Format: "dd/MM/yyyy" (ví dụ: "15/7/2022")
  /// Cần chỉ định liệu tháng có phải là tháng nhuận hay không.
  static LunarDateTime? parseLunar(String formattedString,
      {bool isLeapMonth = false}) {
    try {
      final parts = formattedString.split('/');
      if (parts.length != 3) return null;

      final day = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final year = int.tryParse(parts[2]);

      if (day == null || month == null || year == null) return null;

      return isLeapMonth
          ? LunarDateTime.leapMonth(year, month, day)
          : LunarDateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  /// Kiểm tra xem một tháng cụ thể trong năm có phải là tháng nhuận hay không
  static bool hasLeapMonthInYear(int year, int month) {
    return LunarDateTime(year, month).isLeapMonth;
  }

  /// `true` nếu tháng hiện tại là tháng nhuận.
  final bool isLeapMonth;

  final int day;
  final int hour;
  final int microsecond;
  final int millisecond;
  final int minute;
  final int month;
  final int second;
  final int year;

  /// Tạo một đối tượng [LunarDateTime] từ một đối tượng [DateTime].
  factory LunarDateTime.fromDateTime(DateTime dateTime) {
    // Adjust the DateTime to the fixed +7 timezone.
    final adjustedDateTime = dateTime.toUtc().add(_fixedTimeZoneOffset);

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
      {bool isUtc = false}) {
    return LunarDateTime.fromDateTime(
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: isUtc),
    );
  }

  /// Tạo một đối tượng [LunarDateTime] từ số micro giây kể từ thời điểm Unix epoch.
  factory LunarDateTime.fromMicrosecondsSinceEpoch(int microsecondsSinceEpoch,
      {bool isUtc = false}) {
    return LunarDateTime.fromDateTime(
      DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch, isUtc: isUtc),
    );
  }

  /// Constructor chính cho [LunarDateTime].
  /// Kiểm tra tính hợp lệ của ngày âm lịch.
  LunarDateTime(
    this.year, [
    this.month = 1,
    this.day = 1,
    this.hour = 0,
    this.minute = 0,
    this.second = 0,
    this.millisecond = 0,
    this.microsecond = 0,
  ]) : isLeapMonth = false;

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
  ]);

  /// Tạo một đối tượng [LunarDateTime] cho tháng nhuận.
  /// Kiểm tra xem tháng có phải là tháng nhuận trong năm không.
  LunarDateTime.leapMonth(
    this.year, [
    this.month = 1,
    this.day = 1,
    this.hour = 0,
    this.minute = 0,
    this.second = 0,
    this.millisecond = 0,
    this.microsecond = 0,
  ]) : isLeapMonth = true {
    // Kiểm tra xem tháng có phải là tháng nhuận không
    if (!hasLeapMonthInYear(year, month)) {
      throw ArgumentError('Tháng $month năm $year không phải là tháng nhuận');
    }
  }

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
    // Reset _dateTime vì thông tin đã thay đổi
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
    );
  }

  /// Thêm một khoảng thời gian vào [LunarDateTime] hiện tại.
  LunarDateTime add(Duration duration) {
    return LunarDateTime.fromDateTime(toDateTime().add(duration));
  }

  /// Trừ một khoảng thời gian từ [LunarDateTime] hiện tại.
  LunarDateTime subtract(Duration duration) {
    return LunarDateTime.fromDateTime(toDateTime().subtract(duration));
  }

  /// Thêm một số ngày vào [LunarDateTime] hiện tại.
  LunarDateTime addDays(int days) {
    return add(Duration(days: days));
  }

  /// Thêm một số tháng vào [LunarDateTime] hiện tại.
  /// Cần cẩn thận vì tháng âm lịch có độ dài khác nhau.
  LunarDateTime addMonths(int months) {
    // Chuyển đổi sang DateTime, thêm tháng, rồi chuyển lại
    final dt = toDateTime();
    int newMonth = dt.month + months;
    int yearAdjustment = (newMonth - 1) ~/ 12;
    newMonth = ((newMonth - 1) % 12) + 1;

    final newDateTime = DateTime(
      dt.year + yearAdjustment,
      newMonth,
      dt.day,
      dt.hour,
      dt.minute,
      dt.second,
      dt.millisecond,
      dt.microsecond,
    );

    return LunarDateTime.fromDateTime(newDateTime);
  }

  /// Thêm một số năm vào [LunarDateTime] hiện tại.
  LunarDateTime addYears(int years) {
    // Chuyển đổi sang DateTime, thêm năm, rồi chuyển lại
    final dt = toDateTime();
    final newDateTime = DateTime(
      dt.year + years,
      dt.month,
      dt.day,
      dt.hour,
      dt.minute,
      dt.second,
      dt.millisecond,
      dt.microsecond,
    );

    return LunarDateTime.fromDateTime(newDateTime);
  }

  /// Lấy ngày đầu tiên của tháng
  LunarDateTime firstDayOfMonth() {
    return copyWith(day: 1);
  }

  /// Lấy ngày cuối cùng của tháng
  LunarDateTime lastDayOfMonth() {
    return copyWith()
        .addMonths(1)
        .firstDayOfMonth()
        .subtract(const Duration(days: 1));
  }

  /// So sánh với một [LunarDateTime] khác.
  int compareTo(LunarDateTime other) {
    return toDateTime().compareTo(other.toDateTime());
  }

  /// Tính khoảng thời gian giữa hai đối tượng [LunarDateTime].
  Duration difference(LunarDateTime other) {
    return toDateTime().difference(other.toDateTime());
  }

  /// Kiểm tra xem [LunarDateTime] hiện tại có sau [other] không.
  bool isAfter(LunarDateTime other) {
    return toDateTime().isAfter(other.toDateTime());
  }

  /// Kiểm tra xem [LunarDateTime] hiện tại có cùng thời điểm với [other] không.
  bool isAtSameMomentAs(LunarDateTime other) {
    return toDateTime().isAtSameMomentAs(other.toDateTime());
  }

  /// Kiểm tra xem [LunarDateTime] hiện tại có trước [other] không.
  bool isBefore(LunarDateTime other) {
    return toDateTime().isBefore(other.toDateTime());
  }

  /// Luôn trả về false vì chúng ta đang sử dụng múi giờ cố định +7.
  bool get isUtc => false;

  /// Trả về số micro giây kể từ thời điểm Unix epoch.
  int get microsecondsSinceEpoch => toDateTime().microsecondsSinceEpoch;

  /// Trả về số mili giây kể từ thời điểm Unix epoch.
  int get millisecondsSinceEpoch => toDateTime().millisecondsSinceEpoch;

  /// Trả về tên múi giờ.
  String get timeZoneName => 'ICT'; // Indochina Time.

  /// Trả về độ lệch múi giờ.
  Duration get timeZoneOffset => _fixedTimeZoneOffset;

  /// Chuyển đổi thành chuỗi ISO 8601.
  String toIso8601String() {
    return toDateTime().toIso8601String();
  }

  /// Trả về ngày trong tuần (1 = Thứ Hai, ..., 7 = Chủ Nhật).
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
    return '$day/$month/$year${isLeapMonth ? ' (N)' : ''}';
  }

  /// Phương thức để thực hiện phép cộng.
  LunarDateTime operator +(Duration duration) => add(duration);

  /// Phương thức để thực hiện phép trừ với Duration.
  LunarDateTime operator -(Duration duration) => subtract(duration);

  /// Toán tử so sánh lớn hơn.
  bool operator >(LunarDateTime other) => compareTo(other) > 0;

  /// Toán tử so sánh lớn hơn hoặc bằng.
  bool operator >=(LunarDateTime other) => compareTo(other) >= 0;

  /// Toán tử so sánh nhỏ hơn.
  bool operator <(LunarDateTime other) => compareTo(other) < 0;

  /// Toán tử so sánh nhỏ hơn hoặc bằng.
  bool operator <=(LunarDateTime other) => compareTo(other) <= 0;
}
