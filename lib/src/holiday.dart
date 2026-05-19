/// The kind of a [Holiday] — fixed calendar date or moveable (Easter-based).
enum HolidayKind { fixed, moveable }

/// A Portuguese public holiday.
class Holiday {
  /// Calendar date of the holiday (time component is always midnight UTC).
  final DateTime date;

  /// Official Portuguese name of the holiday.
  final String name;

  /// Whether the date is fixed every year or calculated from Easter.
  final HolidayKind kind;

  const Holiday({
    required this.date,
    required this.name,
    required this.kind,
  });

  @override
  String toString() =>
      'Holiday(${date.toIso8601String().substring(0, 10)}, "$name")';

  @override
  bool operator ==(Object other) =>
      other is Holiday && date == other.date && name == other.name;

  @override
  int get hashCode => Object.hash(date, name);
}
