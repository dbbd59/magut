class DateTimeApp {
  static DateTime now() {
    return DateTimeExtension.current;
  }

  static void setCustomDateTime(DateTime value) {
    DateTimeExtension.customTime = value;
  }
}

extension DateTimeExtension on DateTime {
  static DateTime? customTime;

  static DateTime get current {
    if (customTime != null) {
      return customTime!;
    } else {
      return DateTime.now();
    }
  }

  bool isToday() {
    return day == current.day && month == current.month && year == current.year;
  }

  bool isTomorrow() {
    return day == current.day + 1 &&
        month == current.month &&
        year == current.year;
  }

  bool isSameDay(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }

  bool isSameMonth(DateTime other) {
    return month == other.month && year == other.year;
  }

  int getMonthsPassed() {
    final now = DateTime.now();
    final difference = now.difference(this);

    return difference.inDays ~/ 30;
  }

  bool isPast() {
    return !isToday() && isBefore(current);
  }
}
