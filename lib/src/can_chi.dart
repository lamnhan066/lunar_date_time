import 'dart:math';

import 'package:lunar_date_time/src/utils.dart';

import 'base.dart';
import 'models/can_chi.dart';

/// Lấy Can Chi của tháng dựa trên tháng và năm
/// [month] là tháng (1-12)
/// [year] là năm
String getCanChiMonth(int month, int year) {
  final String chi = chiMonth[month - 1];
  final String can = canYear[year % 10];
  int indexCan = 0;

  if (can == "Giáp" || can == "Kỉ") {
    indexCan = 6;
  }
  if (can == "Ất" || can == "Canh") {
    indexCan = 8;
  }
  if (can == "Bính" || can == "Tân") {
    indexCan = 0;
  }
  if (can == "Đinh" || can == "Nhâm") {
    indexCan = 2;
  }
  if (can == "Mậu" || can == "Quý") {
    indexCan = 4;
  }
  return '${canYear[(indexCan + month - 1) % 10]} $chi';
}

/// Lấy Can Chi của năm
/// [year] là năm
String getCanChiOfYear(int year) {
  return "${can[(year + 6) % 10]} ${chi[(year + 8) % 12]}";
}

/// Lấy Can của giờ dựa trên chỉ số ngày Julian (JDN)
/// [jdn] là chỉ số ngày Julian
String getCanOfHour(int jdn) {
  return can[(jdn - 1) * 2 % 10];
}

/// Lấy Can Chi của ngày dựa trên chỉ số ngày Julian (JDN)
/// [jdn] là chỉ số ngày Julian
String getCanChiOfDay(int jdn) {
  return "${can[(jdn + 9) % 10]} ${chi[(jdn + 1) % 12]}";
}

/// Lấy giờ hoàng đạo dựa trên chỉ số ngày Julian (JDN)
/// [jd] là chỉ số ngày Julian
String getLuckyHour(int jd) {
  final int chiOfDay = (jd + 1) % 12;
  // Các giá trị giống nhau cho Tý (1) và Ngọ (6), Sửu và Mùi, v.v.
  final String gioHD = luckyHour[chiOfDay % 6];
  String ret = "";
  int count = 0;
  for (int i = 0; i < 12; i++) {
    if (gioHD.substring(i, i + 1) == '1') {
      ret += chi[i];
      ret += ' (${(i * 2 + 23) % 24}-${(i * 2 + 1) % 24})';
      if (count++ < 5) ret += ', ';
      if (count == 3) ret += '\n';
    }
  }
  return ret;
}

/// Lấy tiết khí dựa trên chỉ số ngày Julian (JDN)
/// [jd] là chỉ số ngày Julian
String getSolarTerms(int jd) {
  return solarTerms[toInt(sunLongitude(jd + 1 - 0.5 - 7 / 24) / pi * 12)];
}

/// Lấy Can Chi của giờ bắt đầu dựa trên chỉ số ngày Julian (JDN)
/// [jdn] là chỉ số ngày Julian
String getCanChiOfStartHour(int jdn) {
  return '${can[(jdn - 1) * 2 % 10]} ${chi[0]}';
}
