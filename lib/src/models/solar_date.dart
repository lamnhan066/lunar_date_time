/// Lớp đại diện cho ngày dương lịch (Gregorian calendar).
class SolarDate {
  /// Năm của ngày dương lịch.
  final int year;

  /// Tháng của ngày dương lịch.
  final int month;

  /// Ngày của ngày dương lịch.
  final int day;

  /// Hàm khởi tạo cho lớp SolarDate.
  ///
  /// [year] là năm, [month] là tháng, và [day] là ngày của ngày dương lịch.
  SolarDate({
    required this.year,
    required this.month,
    required this.day,
  });
}
