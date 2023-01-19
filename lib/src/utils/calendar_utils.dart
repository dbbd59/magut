import 'package:intl/intl.dart';
import 'package:magut/src/utils/date_utils.dart';

class CalendarUtils {
  static DateTime addMonth(DateTime dateTime, int index) {
    return DateTime(dateTime.year, dateTime.month + index);
  }

  static List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;

    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  static String formatDateTimeToMonthYear(DateTime monthAndYear) {
    final formatter = DateFormat(
      'MMMM yyyy',
    );
    final formatted = formatter.format(monthAndYear);

    return formatted;
  }

  static String formatDateTimeToMonth(DateTime monthAndYear) {
    final formatter = DateFormat(
      'MMMM',
    );
    final formatted = formatter.format(monthAndYear);

    return formatted;
  }

  static String formatDateTimeToYear(DateTime monthAndYear) {
    final formatter = DateFormat(
      'yyyy',
    );
    final formatted = formatter.format(monthAndYear);

    return formatted;
  }

  static List<String> getDaysOfWeek(String locale) {
    return _rotate(
      DateFormat.EEEE(
        locale,
      ).dateSymbols.STANDALONESHORTWEEKDAYS,
      1,
    ) as List<String>;
  }

  static DateTime getMonthAndYearFromIndex(int index) {
    final now = DateTimeApp.now();
    var monthAndYear = DateTime(now.year, now.month);
    monthAndYear = addMonth(now, index);

    return monthAndYear;
  }

  static String getMonthAndYearStringFromIndex(int index) {
    return formatDateTimeToMonthYear(getMonthAndYearFromIndex(index));
  }

  static String getMonthStringFromIndex(int index) {
    return formatDateTimeToMonth(getMonthAndYearFromIndex(index));
  }

  static String getYearStringFromIndex(int index) {
    return formatDateTimeToYear(getMonthAndYearFromIndex(index));
  }

  static List<DateTime> getMonthDaysFromIndex(int index) {
    final now = DateTimeApp.now();
    var monthAndYear = DateTime(now.year, now.month);
    monthAndYear = addMonth(now, index);

    final monthDays = <DateTime>[];
    final firstDayOfMonth = DateTime(monthAndYear.year, monthAndYear.month);
    final lastDayOfMonth = DateTime(monthAndYear.year, monthAndYear.month + 1);

    for (var day = firstDayOfMonth;
        day.isBefore(lastDayOfMonth);
        day = day.add(const Duration(days: 1))) {
      monthDays.add(day);
    }

    return monthDays;
  }

  static bool isInList(DateTime dateTime, List<DateTime>? list) {
    if (list == null) {
      return false;
    }

    return list.any((element) => isSameDay(dateTime, element));
  }

  static bool isLowerBound(DateTime date, List<DateTime>? dates) {
    if (dates == null) {
      return false;
    }

    final d = sortDates(dates);

    return isSameDay(d!.first, date);
  }

  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isUpperBound(DateTime date, List<DateTime>? dates) {
    if (dates == null) {
      return false;
    }

    final d = sortDates(dates);

    return isSameDay(d!.last, date);
  }

  static int monthDifference(DateTime first, DateTime last) {
    return (last.year - first.year) * 12 + last.month - first.month;
  }

  static List<DateTime>? sortDates(List<DateTime>? dates) {
    if (dates == null) {
      return null;
    }

    return dates.toList()..sort((a, b) => a.compareTo(b));
  }

  static List<Object> _rotate(List<Object> list, int v) {
    if (list.isEmpty) {
      return list;
    }
    final i = v % list.length;

    return list.sublist(i)..addAll(list.sublist(0, i));
  }

  static int weekNumber(DateTime date) {
    final dayOfYear = int.parse(DateFormat('D').format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
}

enum StartingDayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}
