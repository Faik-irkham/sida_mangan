import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    // Date and Time Format
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpesific = "07:37:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    //Today format
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpesific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    //tomorow Format
    var formatted = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpesific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
