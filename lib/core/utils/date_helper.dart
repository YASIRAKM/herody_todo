import 'package:intl/intl.dart';

class DateHelper {
  static String formatToDDMMYYYY(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static DateTime parseFromDDMMYYYY(String dateString) {
    return DateFormat('dd-MM-yyyy').parse(dateString);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }
}
