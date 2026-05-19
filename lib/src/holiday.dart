/// The kind of a [Holiday] — fixed calendar date or moveable (Easter-based).
enum HolidayKind { fixed, moveable }

/// The scope of a [Holiday] — national, regional (Açores/Madeira), or municipal.
enum HolidayScope { national, regional, municipal }

/// A Portuguese public holiday.
class Holiday {
  /// Calendar date of the holiday (time component is always midnight).
  final DateTime date;

  /// Official Portuguese name of the holiday.
  final String name;

  /// Whether the date is fixed every year or calculated from Easter.
  final HolidayKind kind;

  /// Whether this is a national, regional, or municipal holiday.
  final HolidayScope scope;

  /// Optional description from the SAPO API.
  final String? description;

  const Holiday({
    required this.date,
    required this.name,
    required this.kind,
    this.scope = HolidayScope.national,
    this.description,
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
