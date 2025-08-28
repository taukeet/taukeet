import 'package:taukeet/generated/l10n.dart';

extension StringCasingExtension on String {
  String capitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String humanReadable() =>
      replaceAllMapped(RegExp(r'[A-Z]'), (match) => ' ${match.group(0)}')
          .trim();

  String toCamelCase() {
    List<String> words = replaceAll(RegExp(r'[_\-\s]+'), ' ')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) return '';

    String result = words.first.toLowerCase();
    for (int i = 1; i < words.length; i++) {
      result += words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }

    return result;
  }

  String lowercaseFirstChar() {
    if (isEmpty) return this;
    return this[0].toLowerCase() + substring(1);
  }
}

extension DateTimeExtensions on DateTime {
  bool isToday() {
    final currentDate = DateTime.now();
    return year == currentDate.year &&
        month == currentDate.month &&
        day == currentDate.day;
  }
}
