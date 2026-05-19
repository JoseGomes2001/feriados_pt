import 'package:feriados_pt/feriados_pt.dart';
import 'package:test/test.dart';

void main() {
  // ─── Easter algorithm ──────────────────────────────────────────────────────
  group('Easter dates (known values)', () {
    final cases = {
      2020: DateTime(2020, 4, 12),
      2021: DateTime(2021, 4, 4),
      2022: DateTime(2022, 4, 17),
      2023: DateTime(2023, 4, 9),
      2024: DateTime(2024, 3, 31),
      2025: DateTime(2025, 4, 20),
      2026: DateTime(2026, 4, 5),
    };

    for (final entry in cases.entries) {
      test('Easter ${entry.key}', () {
        final h = getHolidays(entry.key)
            .firstWhere((h) => h.name == 'Domingo de Páscoa');
        expect(h.date, entry.value);
      });
    }
  });

  // ─── Fixed holidays ────────────────────────────────────────────────────────
  group('Fixed holidays present every year', () {
    for (final year in [2019, 2022, 2026]) {
      test('year $year', () {
        final holidays = getHolidays(year);
        final dates = holidays.map((h) => h.date).toSet();

        expect(dates, contains(DateTime(year, 1, 1)));
        expect(dates, contains(DateTime(year, 4, 25)));
        expect(dates, contains(DateTime(year, 5, 1)));
        expect(dates, contains(DateTime(year, 6, 10)));
        expect(dates, contains(DateTime(year, 8, 15)));
        expect(dates, contains(DateTime(year, 10, 5)));
        expect(dates, contains(DateTime(year, 12, 25)));
      });
    }
  });

  // ─── Suppression period 2013–2015 ─────────────────────────────────────────
  group('Suppression period (2013–2015)', () {
    const suppressedNames = [
      'Corpo de Deus',
      'Dia de Todos os Santos',
      'Restauração da Independência',
      'Imaculada Conceição',
    ];

    for (final year in [2013, 2014, 2015]) {
      test('$year should NOT have suppressed holidays', () {
        final names = getHolidays(year).map((h) => h.name).toSet();
        for (final name in suppressedNames) {
          expect(names, isNot(contains(name)), reason: '$name in $year');
        }
      });
    }

    for (final year in [2012, 2016, 2026]) {
      test('$year should have all four reinstated holidays', () {
        final names = getHolidays(year).map((h) => h.name).toSet();
        for (final name in suppressedNames) {
          expect(names, contains(name), reason: '$name missing in $year');
        }
      });
    }
  });

  // ─── Holiday counts ────────────────────────────────────────────────────────
  test('2022 has 13 holidays', () => expect(getHolidays(2022).length, 13));
  test('2014 has 9 holidays (suppression)', () => expect(getHolidays(2014).length, 9));

  // ─── isHoliday / holidayAt ─────────────────────────────────────────────────
  group('isHoliday', () {
    test('25 de Abril é feriado', () {
      expect(isHoliday(DateTime(2026, 4, 25)), isTrue);
    });

    test('dia normal não é feriado', () {
      expect(isHoliday(DateTime(2026, 3, 10)), isFalse);
    });
  });

  group('holidayAt', () {
    test('retorna o feriado correto', () {
      final h = holidayAt(DateTime(2026, 4, 25));
      expect(h, isNotNull);
      expect(h!.name, 'Dia da Liberdade');
      expect(h.kind, HolidayKind.fixed);
    });

    test('retorna null para dia normal', () {
      expect(holidayAt(DateTime(2026, 3, 10)), isNull);
    });

    test('ignora componente de hora', () {
      expect(
        holidayAt(DateTime(2026, 12, 25, 15, 30)),
        isNotNull,
      );
    });
  });

  // ─── Sort order ────────────────────────────────────────────────────────────
  test('holidays are sorted by date', () {
    final holidays = getHolidays(2026);
    for (var i = 0; i < holidays.length - 1; i++) {
      expect(
        holidays[i].date.isBefore(holidays[i + 1].date),
        isTrue,
        reason: '${holidays[i]} should be before ${holidays[i + 1]}',
      );
    }
  });

  // ─── Corpus Christi offset ─────────────────────────────────────────────────
  test('Corpo de Deus é 60 dias após a Páscoa', () {
    final holidays = getHolidays(2026);
    final easter = holidays.firstWhere((h) => h.name == 'Domingo de Páscoa');
    final corpus = holidays.firstWhere((h) => h.name == 'Corpo de Deus');
    expect(
      corpus.date.difference(easter.date).inDays,
      60,
    );
  });
}
