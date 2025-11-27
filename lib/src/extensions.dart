import 'package:lunar_date_time/lunar_date_time.dart';
import 'package:timezone/timezone.dart' as tz;

extension TZDateTimeEx on tz.TZDateTime {
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

  LunarDateTime dateOnly() {
    return LunarDateTime(year, month, day);
  }
}

extension SolarEx on SolarDateTime {
  LunarDateTime toLunar() {
    return LunarDateTime.fromDateTime(toDateTime());
  }

  SolarDateTime dateOnly() {
    return SolarDateTime(year, month, day);
  }
}
