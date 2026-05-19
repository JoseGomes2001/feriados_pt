import 'package:feriados_pt/feriados_pt.dart';

void main() async {
  // ─── Feriados nacionais (offline) ─────────────────────────────────────────
  print('=== Feriados Nacionais 2026 ===');
  for (final h in getHolidays(2026)) {
    final date = h.date.toIso8601String().substring(0, 10);
    final kind = h.kind == HolidayKind.fixed ? 'fixo' : 'móvel';
    print('$date  ${h.name} ($kind)');
  }

  print('');

  // Verificar uma data específica
  final liberation = DateTime(2026, 4, 25);
  if (isHoliday(liberation)) {
    print('25 de Abril: ${holidayAt(liberation)!.name}');
  }

  // Dias úteis entre duas datas
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

  print('');

  // ─── Feriados municipais (via API SAPO) ────────────────────────────────────
  print('=== Feriados Municipais de Lisboa 2026 ===');
  final lisboaHolidays = await getHolidaysByMunicipality(2026, Municipio.lisboa);
  for (final h in lisboaHolidays) {
    final date = h.date.toIso8601String().substring(0, 10);
    print('$date  ${h.name}');
  }

  print('');

  // Lookup por nome (tolerante a maiúsculas e acentos)
  print('=== Feriados do Porto 2026 (com nacionais) ===');
  final portoHolidays = await getHolidaysByMunicipality(
    2026,
    Municipio.find('porto'),
    includeNational: true,
  );
  for (final h in portoHolidays) {
    final date = h.date.toIso8601String().substring(0, 10);
    print('$date  ${h.name} (${h.scope.name})');
  }

  print('');

  // ─── Feriados regionais (via API SAPO) ────────────────────────────────────
  print('=== Feriados Regionais 2026 ===');
  final regionais = await getRegionalHolidays(2026);
  for (final h in regionais) {
    final date = h.date.toIso8601String().substring(0, 10);
    print('$date  ${h.name}');
  }
}
