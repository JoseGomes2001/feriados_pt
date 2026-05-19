import 'easter.dart';
import 'holiday.dart';

export 'holiday.dart';

/// Returns all mandatory Portuguese national holidays for [year], sorted by
/// date.
///
/// Handles the 2013–2015 suppression period (Lei 23/2012) during which four
/// holidays were eliminated and later reinstated (Lei 8/2016):
/// *Corpo de Deus*, *Dia de Todos os Santos*, *Restauração da Independência*
/// and *Imaculada Conceição*.
List<Holiday> getHolidays(int year) {
  final easter = computeEaster(year);

  // Holidays removed between 2013 and 2015 (inclusive).
  final suppressed = year >= 2013 && year <= 2015;

  final list = <Holiday>[
    _fixed(year, 1, 1, 'Ano Novo'),
    _moveable(easter, -2, 'Sexta-feira Santa'),
    _moveable(easter, 0, 'Domingo de Páscoa'),
    _fixed(year, 4, 25, 'Dia da Liberdade'),
    _fixed(year, 5, 1, 'Dia do Trabalhador'),
    _fixed(year, 6, 10, 'Dia de Portugal, de Camões e das Comunidades Portuguesas'),
    _fixed(year, 8, 15, 'Assunção de Nossa Senhora'),
    _fixed(year, 10, 5, 'Implantação da República'),
    _fixed(year, 12, 25, 'Natal'),
  ];

  if (!suppressed) {
    list.addAll([
      _moveable(easter, 60, 'Corpo de Deus'),
      _fixed(year, 11, 1, 'Dia de Todos os Santos'),
      _fixed(year, 12, 1, 'Restauração da Independência'),
      _fixed(year, 12, 8, 'Imaculada Conceição'),
    ]);
  }

  list.sort((a, b) => a.date.compareTo(b.date));
  return list;
}

/// Returns the [Holiday] that falls on [date], or `null` if it is not a
/// public holiday.
Holiday? holidayAt(DateTime date) {
  final d = DateTime(date.year, date.month, date.day);
  for (final h in getHolidays(date.year)) {
    if (h.date == d) return h;
  }
  return null;
}

/// Returns `true` if [date] is a Portuguese national public holiday.
bool isHoliday(DateTime date) => holidayAt(date) != null;

// ─── helpers ─────────────────────────────────────────────────────────────────

Holiday _fixed(int year, int month, int day, String name) => Holiday(
      date: DateTime(year, month, day),
      name: name,
      kind: HolidayKind.fixed,
    );

Holiday _moveable(DateTime easter, int offset, String name) => Holiday(
      date: easter.add(Duration(days: offset)),
      name: name,
      kind: HolidayKind.moveable,
    );
