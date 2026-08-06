/// Extensions for [DateTime]

extension DateTimeExtensionX on DateTime {
  String get toFormattedDate => '$day/$month/$year';
  String get toFormattedTime => '$hour:$minute';

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  int get daysDifference => DateTime.now().difference(this).inDays;
}
