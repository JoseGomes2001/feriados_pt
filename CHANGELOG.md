## 0.2.1

- Correcção de ficheiros em falta na publicação inicial da 0.2.0.

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
