import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:intl/intl.dart';

class DateTimeStorage {
  DateTimeStorage._();

  /// Current UTC timestamp.
  static String nowUtc() {
    return DateTime.now().toUtc().toIso8601String();
  }

  /// Store an instant as UTC ISO 8601.
  static String toUtc(DateTime date) {
    return date.toUtc().toIso8601String();
  }

  /// Read a UTC timestamp and convert it to local time.
  static DateTime fromUtc(String value) {
    return DateTime.parse(value.trim()).toLocal();
  }

  /// Store a calendar date without timezone conversion (yyyy-MM-dd).
  static String dateOnly(DateTime date) {
    return date.toIsoDateOnly;
  }

  /// Read a date-only value (yyyy-MM-dd) safely.
  static DateTime fromDateOnly(String value) {
    final trimmed = value.trim();
    final parts = trimmed.split('-');
    if (parts.length != 3) {
      throw FormatException('Invalid ISO date-only format', value);
    }

    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  /// Parses ISO strings or legacy formats like dd-MM-yyyy / dd/MM/yyyy.
  static DateTime? tryParseAny(dynamic rawValue) {
    if (rawValue == null) return null;
    final text = rawValue.toString().trim();
    if (text.isEmpty) return null;

    final iso = DateTime.tryParse(text);
    if (iso != null) return iso;

    const legacyPatterns = ['dd-MM-yyyy', 'dd/MM/yyyy', 'yyyy/MM/dd'];
    for (final pattern in legacyPatterns) {
      try {
        return DateFormat(pattern).parseStrict(text);
      } on FormatException {
        continue;
      }
    }

    return null;
  }
}
