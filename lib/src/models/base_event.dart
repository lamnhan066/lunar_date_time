import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:lunar_date_time/lunar_date_time.dart';

/// Lớp đại diện cho một sự kiện cơ bản.
/// [D] là kiểu dữ liệu mở rộng từ `BaseDateTime`.
abstract class BaseEvent<D extends BaseDateTime> extends Equatable {
  /// Ngày của sự kiện.
  final D date;

  /// Tiêu đề của sự kiện.
  final String title;

  /// Mô tả chi tiết của sự kiện.
  final String description;

  /// Địa điểm của sự kiện.
  final String location;

  /// ID duy nhất của sự kiện.
  final String id;

  /// Mức độ ưu tiên của sự kiện.
  final EventPriority priority;

  /// Thông tin lặp lại của sự kiện.
  final BaseRepeat<D> repeat;

  /// Chế độ của sự kiện.
  final EventMode mode;

  /// Xác định sự kiện có chứa thời gian hay không.
  final bool containTime;

  /// Xác định sự kiện có phải là ngày cuối tháng hay không.
  final bool isEndOfMonth;

  /// Ngày tạo sự kiện.
  final DateTime createdDate;

  /// Hàm khởi tạo cho `BaseEvent`.
  BaseEvent({
    required this.date,
    required this.title,
    required this.description,
    required this.location,
    required this.id,
    required this.priority,
    required this.repeat,
    required this.mode,
    required this.containTime,
    required this.isEndOfMonth,
    required this.createdDate,
  });

  /// Chuyển đổi sự kiện sang định dạng JSON.
  String toJson() => jsonEncode(toMap());

  /// Chuyển đổi sự kiện sang dạng `Map`.
  Map<String, dynamic> toMap();

  @override

  /// Danh sách các thuộc tính được sử dụng để so sánh các đối tượng.
  List<Object?> get props {
    return [
      date,
      title,
      description,
      location,
      id,
      priority,
      repeat,
      mode,
      containTime,
      isEndOfMonth,
      createdDate,
    ];
  }
}

/// Lớp đại diện cho thông tin lặp lại của một sự kiện.
/// [D] là kiểu dữ liệu mở rộng từ `BaseDateTime`.
abstract class BaseRepeat<D extends BaseDateTime> extends Equatable {
  /// Ngày bắt đầu của chu kỳ lặp.
  final D fromDate;

  /// Ngày kết thúc của chu kỳ lặp.
  final D toDate;

  /// Tần suất lặp lại.
  final RepeatFrequency frequency;

  /// Số lần lặp lại.
  final int every;

  /// Hàm khởi tạo cho `BaseRepeat`.
  const BaseRepeat({
    required this.fromDate,
    required this.toDate,
    required this.frequency,
    required this.every,
  });

  /// Chuyển đổi thông tin lặp lại sang định dạng JSON.
  String toJson() => jsonEncode(toMap());

  /// Chuyển đổi thông tin lặp lại sang dạng `Map`.
  Map<String, dynamic> toMap();

  @override

  /// Danh sách các thuộc tính được sử dụng để so sánh các đối tượng.
  List<Object> get props => [fromDate, toDate, frequency, every];
}
