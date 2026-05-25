/// Portuguese public holidays for Dart and Flutter.
///
/// **Offline (national holidays):**
/// ```dart
/// import 'package:feriados_pt/feriados_pt.dart';
///
/// final holidays = getHolidays(2026);
/// isHoliday(DateTime.now());
/// holidayAt(DateTime(2026, 4, 25))?.name; // Dia da Liberdade
/// ```
///
/// **Online (municipal / regional holidays via SAPO API):**
/// ```dart
/// // Feriados do município 1 (Lisboa)
/// final local = await getHolidaysByMunicipality(2026, '1');
///
/// // Todos os municipais de Portugal
/// final all = await getMunicipalHolidays(2026);
///
/// // Açores e Madeira
/// final regional = await getRegionalHolidays(2026);
/// ```
library;

export 'src/feriados_pt_base.dart'
    show getHolidays, holidayAt, isHoliday, Holiday, HolidayKind, HolidayScope;

export 'src/sapo_client.dart'
    show
        getHolidaysByMunicipality,
        getMunicipalHolidays,
        getRegionalHolidays,
        Municipio,
        SapoApiException;
