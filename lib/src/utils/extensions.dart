extension StringCasingExtension on String {
  String capitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String humanReadable() =>
      replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}')
          .trim();
}

extension DateTimeExtensions on DateTime {
  bool isToday() {
    final currentDate = DateTime.now();
    return year == currentDate.year &&
        month == currentDate.month &&
        day == currentDate.day;
  }
}
