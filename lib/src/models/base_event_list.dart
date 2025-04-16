import 'dart:convert';

import 'base_event.dart';

abstract class BaseEventList<D extends Object> {
  final Map<D, List<BaseEvent<D>>> events;

  BaseEventList({required this.events});

  void add(D date, BaseEvent<D> event);

  void addAll(D date, List<BaseEvent<D>> events);

  bool remove(D date, BaseEvent<D> event);

  List<BaseEvent<D>> removeAll(D date);

  List<BaseEvent<D>> getEvents(D date);

  void clear();

  Map<String, dynamic> toMap();

  String toJson() => jsonEncode(toMap());
}
