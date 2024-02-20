import 'package:lunar_date_time/src/lunar_date_time.dart';

/// Convert from solar (normal DateTime) to LunarDateTime.
extension SolarToLunarConverter on DateTime {
  LunarDateTime get toLunar => LunarDateTime.fromDateTime(this);
}
