/// Portuguese national public holidays for Dart and Flutter.
///
/// ```dart
/// import 'package:feriados_pt/feriados_pt.dart';
///
/// // List all holidays for a year
/// final holidays = getHolidays(2026);
///
/// // Check if today is a holiday
/// if (isHoliday(DateTime.now())) { ... }
///
/// // Get the holiday name for a date
/// final h = holidayAt(DateTime(2026, 4, 25));
/// print(h?.name); // Dia da Liberdade
/// ```
library feriados_pt;

export 'src/feriados_pt_base.dart'
    show getHolidays, holidayAt, isHoliday, Holiday, HolidayKind;
