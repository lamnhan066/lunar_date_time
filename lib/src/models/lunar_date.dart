/// Lớp đại diện cho một ngày âm lịch.
///
/// Các thuộc tính của lớp này bao gồm thông tin về năm, tháng, ngày,
/// tháng nhuận và số ngày Julian.
class LunarDate {
  /// Năm âm lịch.
  final int year;

  /// Tháng âm lịch.
  final int month;

  /// Ngày âm lịch.
  final int day;

  /// Xác định tháng này có phải là tháng nhuận hay không.
  final bool isLeapMonth;

  /// Số ngày Julian tương ứng với ngày âm lịch này.
  final int julianDayNumber;

  /// Tạo một đối tượng LunarDate với các thông tin cụ thể.
  ///
  /// [year] là năm âm lịch.
  /// [month] là tháng âm lịch.
  /// [day] là ngày âm lịch.
  /// [isLeapMonth] xác định tháng này có phải là tháng nhuận hay không.
  /// [julianDayNumber] là số ngày Julian tương ứng.
  LunarDate({
    required this.year,
    required this.month,
    required this.day,
    required this.isLeapMonth,
    required this.julianDayNumber,
  });
}
