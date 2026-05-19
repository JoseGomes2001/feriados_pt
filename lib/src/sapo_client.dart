import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import 'holiday.dart';
import 'municipios.dart';

export 'municipios.dart' show Municipio;

const _base = 'https://services.sapo.pt/Holiday';

/// Returns all municipal holidays for [year] across Portugal.
Future<List<Holiday>> getMunicipalHolidays(int year) =>
    _fetch(Uri.parse('$_base/GetLocalHolidays?year=$year'), HolidayScope.municipal);

/// Returns regional holidays for [year] (Açores and Madeira).
Future<List<Holiday>> getRegionalHolidays(int year) =>
    _fetch(Uri.parse('$_base/GetRegionalHolidays?year=$year'), HolidayScope.regional);

/// Returns holidays for a specific [municipio] in [year].
///
/// ```dart
/// await getHolidaysByMunicipality(2026, Municipio.lisboa);
/// await getHolidaysByMunicipality(2026, Municipio.find('porto'));
/// ```
///
/// Set [includeNational] to `true` to also include national holidays.
Future<List<Holiday>> getHolidaysByMunicipality(
  int year,
  Municipio municipio, {
  bool includeNational = false,
}) =>
    _fetch(
      Uri.parse(
        '$_base/GetHolidaysByMunicipalityId'
        '?year=$year&municipalityId=${municipio.id}&includeNational=$includeNational',
      ),
      HolidayScope.municipal,
    );

// ─── internals ───────────────────────────────────────────────────────────────

Future<List<Holiday>> _fetch(Uri uri, HolidayScope defaultScope) async {
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw SapoApiException('HTTP ${response.statusCode} for $uri');
  }
  return _parse(response.body, defaultScope);
}

List<Holiday> _parse(String body, HolidayScope defaultScope) {
  final doc = XmlDocument.parse(body);
  return doc.findAllElements('Holiday').map((e) {
    final dateStr = e.findElements('Date').first.innerText;
    final name = e.findElements('Name').first.innerText;
    final desc = e.findElements('Description').firstOrNull?.innerText;
    final typeStr = e.findElements('Type').firstOrNull?.innerText ?? '';

    return Holiday(
      date: DateTime.parse(dateStr),
      name: name,
      kind: HolidayKind.fixed,
      scope: _scopeFromApiType(typeStr, defaultScope),
      description: (desc == null || desc.isEmpty) ? null : desc,
    );
  }).toList()
    ..sort((a, b) => a.date.compareTo(b.date));
}

HolidayScope _scopeFromApiType(String type, HolidayScope fallback) =>
    switch (type.toLowerCase()) {
      'national' => HolidayScope.national,
      'regional' => HolidayScope.regional,
      'municipal' => HolidayScope.municipal,
      _ => fallback,
    };

/// Thrown when the SAPO Holiday API returns an unexpected response.
class SapoApiException implements Exception {
  final String message;
  const SapoApiException(this.message);

  @override
  String toString() => 'SapoApiException: $message';
}
