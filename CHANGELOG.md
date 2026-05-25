## 0.2.2

- Removed named library directive to follow Dart 3 conventions.
- Fixed pubspec.yaml description length (was exceeding pub.dev's 180-character limit).
- Updated dependencies: `http ^1.6.0`, `xml ^7.0.1`, `lints ^6.1.0`, `test ^1.31.1`.

## 0.2.1

- Fixed missing files from the initial 0.2.0 publish.

## 0.2.0

- Added `getHolidaysByMunicipality(year, municipio)` — fetches municipal holidays from the SAPO API for a specific municipality.
- Added `getMunicipalHolidays(year)` — fetches all municipal holidays across Portugal.
- Added `getRegionalHolidays(year)` — fetches regional holidays for Açores and Madeira.
- Added `Municipio` enum with all ~300 Portuguese municipalities, each with `id` and `nome` fields.
- Added `Municipio.find(nome)` — case-insensitive, accent-tolerant lookup by name.
- Added `HolidayScope` enum (`national`, `regional`, `municipal`) to `Holiday`.
- Added optional `description` field to `Holiday`.
- New dependencies: `http`, `xml`.

## 0.1.0

- Initial release.
- `getHolidays(year)` — returns all mandatory Portuguese national holidays sorted by date.
- `isHoliday(date)` — checks whether a date is a public holiday.
- `holidayAt(date)` — returns the `Holiday` for a date, or `null`.
- Correct handling of the 2013–2015 suppression period (Lei 23/2012 / Lei 8/2016).
- Easter calculated with the Meeus/Jones/Butcher algorithm.
