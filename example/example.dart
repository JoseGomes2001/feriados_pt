import 'package:feriados_pt/feriados_pt.dart';

void main() {
  // List all holidays for 2026
  print('=== Feriados Nacionais 2026 ===');
  for (final h in getHolidays(2026)) {
    final date = h.date.toIso8601String().substring(0, 10);
    final kind = h.kind == HolidayKind.fixed ? 'fixo' : 'móvel';
    print('$date  ${h.name} ($kind)');
  }

  print('');

  // Check a specific date
  final liberation = DateTime(2026, 4, 25);
  if (isHoliday(liberation)) {
    print('25 de Abril: ${holidayAt(liberation)!.name}');
  }

  // Count working days in a range, excluding holidays and weekends
  final start = DateTime(2026, 4, 20);
  final end = DateTime(2026, 4, 30);
  var workingDays = 0;
  var d = start;
  while (!d.isAfter(end)) {
    if (d.weekday != DateTime.saturday &&
        d.weekday != DateTime.sunday &&
        !isHoliday(d)) {
      workingDays++;
    }
    d = d.add(const Duration(days: 1));
  }
  print('\nDias úteis entre 20 e 30 de Abril de 2026: $workingDays');
}
