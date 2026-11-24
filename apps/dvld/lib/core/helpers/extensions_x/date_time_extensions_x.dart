/// Extensions for [DateTime?] with Null-Safety and double-digit formatting
extension DateTimeExtensionX on DateTime? {
  String get toFormattedDateTime {
    if (this == null) return '';

    final dayStr = this!.day.toString().padLeft(2, '0');
    final monthStr = this!.month.toString();
    final yearStr = this!.year;

    final hour12 = this!.hour % 12 == 0 ? 12 : this!.hour % 12;
    final minuteStr = this!.minute.toString().padLeft(2, '0');
    final secondStr = this!.second.toString().padLeft(2, '0');
    final period = this!.hour >= 12 ? 'PM' : 'AM';

    return '$monthStr/$dayStr/$yearStr $hour12:$minuteStr:$secondStr $period';
  }

  String get toFormattedDate {
    if (this == null) return '';
    final dayStr = this!.day.toString().padLeft(2, '0');
    final monthStr = this!.month.toString().padLeft(2, '0');
    return '$dayStr/$monthStr/${this!.year}';
  }

  String get toFormattedTime {
    if (this == null) return '';
    final hourStr = this!.hour.toString().padLeft(2, '0');
    final minuteStr = this!.minute.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr';
  }

  bool get isToday {
    if (this == null) return false;
    final now = DateTime.now();
    return this!.year == now.year &&
        this!.month == now.month &&
        this!.day == now.day;
  }

  bool get isYesterday {
    if (this == null) return false;
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return this!.year == yesterday.year &&
        this!.month == yesterday.month &&
        this!.day == yesterday.day;
  }

  int get daysDifference {
    if (this == null) return 0;
    return DateTime.now().difference(this!).inDays;
  }
}
