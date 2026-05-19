## 0.1.0

- Initial release.
- `getHolidays(year)` — returns all mandatory Portuguese national holidays sorted by date.
- `isHoliday(date)` — checks whether a date is a public holiday.
- `holidayAt(date)` — returns the `Holiday` for a date, or `null`.
- Correct handling of the 2013–2015 suppression period (Lei 23/2012 / Lei 8/2016).
- Easter calculated with the Meeus/Jones/Butcher algorithm.
