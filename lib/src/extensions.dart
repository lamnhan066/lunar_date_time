import 'package:lunar_date_time/lunar_date_time.dart';

extension DateTimeEx on DateTime {
  SolarDateTime toSolar() {
    return SolarDateTime.fromDateTime(this);
  }

  LunarDateTime toLunar() {
    return LunarDateTime.fromDateTime(this);
  }
}

extension LunarEx on LunarDateTime {
  SolarDateTime toSolar() {
    return SolarDateTime.fromDateTime(toDateTime());
  }
}

extension SolarEx on SolarDateTime {
  LunarDateTime toLunar() {
    return LunarDateTime.fromDateTime(toDateTime());
  }
}
