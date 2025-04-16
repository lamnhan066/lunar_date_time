import 'dart:convert';

import 'package:lunar_date_time/src/models/base_date_time.dart';

import 'base_event.dart';

/// Lớp trừu tượng đại diện cho danh sách các sự kiện.
/// [D] là kiểu dữ liệu mở rộng từ BaseDateTime.
abstract class BaseEventList<D extends BaseDateTime> {
  /// Bản đồ chứa các sự kiện, với key là ngày [D] và value là danh sách các sự kiện [BaseEvent<D>].
  final Map<D, List<BaseEvent<D>>> events;

  /// Constructor nhận vào một bản đồ các sự kiện.
  BaseEventList({required this.events});

  /// Thêm một sự kiện [event] vào ngày [date].
  void add(D date, BaseEvent<D> event);

  /// Thêm nhiều sự kiện [events] vào ngày [date].
  void addAll(D date, List<BaseEvent<D>> events);

  /// Xóa một sự kiện [event] khỏi ngày [date].
  /// Trả về true nếu xóa thành công, ngược lại trả về false.
  bool remove(D date, BaseEvent<D> event);

  /// Xóa tất cả các sự kiện khỏi ngày [date].
  /// Trả về danh sách các sự kiện đã bị xóa.
  List<BaseEvent<D>> removeAll(D date);

  /// Lấy danh sách các sự kiện của ngày [date].
  List<BaseEvent<D>> getEvents(D date);

  /// Xóa tất cả các sự kiện trong danh sách.
  void clear();

  /// Chuyển đổi danh sách sự kiện thành một bản đồ.
  Map<String, dynamic> toMap();

  /// Chuyển đổi danh sách sự kiện thành chuỗi JSON.
  String toJson() => jsonEncode(toMap());
}
