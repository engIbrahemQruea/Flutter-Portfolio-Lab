/// Extensions for [DateTime?] with null-safety,
/// formatting, date comparisons, and calendar operations.
extension DateTimeExtensionX on DateTime? {
  // --------------------------------------------------
  // Formatting
  // --------------------------------------------------

  /// Format: MM/dd/yyyy hh:mm:ss AM/PM
  String get toFormattedDateTime {
    final date = this;
    if (date == null) return '';

    final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour >= 12 ? 'PM' : 'AM';

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    final second = date.second.toString().padLeft(2, '0');

    return '$month/$day/${date.year} '
        '$hour12:$minute:$second $period';
  }

  /// Format: dd/MM/yyyy
  String get toFormattedDate {
    final date = this;
    if (date == null) return '';

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  /// Format: HH:mm
  String get toFormattedTime {
    final date = this;
    if (date == null) return '';

    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  /// Format: yyyy-MM-dd
  String get toIsoDateOnly {
    final date = this;
    if (date == null) return '';

    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  // --------------------------------------------------
  // Database / UTC
  // --------------------------------------------------

  /// Convert a timestamp to UTC ISO 8601 for database storage.
  String? get toUtcDatabaseString {
    return this?.toUtc().toIso8601String();
  }

  /// Convert a DateTime to a UTC DateTime.
  DateTime? get toUtcDateTime {
    return this?.toUtc();
  }

  /// Convert a DateTime to local time.
  DateTime? get toLocalDateTime {
    return this?.toLocal();
  }

  // --------------------------------------------------
  // Date comparisons
  // --------------------------------------------------

  /// Whether this date is today (local calendar date).
  bool get isToday {
    final date = this;
    if (date == null) return false;

    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Whether this date is yesterday (local calendar date).
  bool get isYesterday {
    final date = this;
    if (date == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Difference in whole days from this date to now.
  int get daysDifference {
    final date = this;
    if (date == null) return 0;

    return DateTime.now().difference(date).inDays;
  }

  /// Compare only calendar dates, ignoring time.
  bool isSameDate(DateTime? other) {
    final date = this;
    if (date == null || other == null) return false;

    return date.year == other.year &&
        date.month == other.month &&
        date.day == other.day;
  }

  // --------------------------------------------------
  // Calendar operations
  // --------------------------------------------------

  /// Add one calendar year, preserving time and timezone mode.
  /// February 29 becomes February 28 when the target year is not leap.
  DateTime? addOneYear() {
    final date = this;
    if (date == null) return null;

    final targetYear = date.year + 1;

    final lastDayOfTargetMonth = DateTime(targetYear, date.month + 1, 0).day;

    return DateTime(
      targetYear,
      date.month,
      date.day > lastDayOfTargetMonth ? lastDayOfTargetMonth : date.day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );
  }
}
