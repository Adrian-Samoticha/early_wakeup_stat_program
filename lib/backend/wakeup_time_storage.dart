import 'package:shared_preferences/shared_preferences.dart';

class WakeupTimeStorage {
  static final Map<String, DateTime> _dateToWakeupTime = {};
  
  static void reset() {
    _dateToWakeupTime.clear();
  }
  
  static String dateTimeToDateString(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  }
  
  static void setWakeupTime(DateTime wakeupTime) {
    final dateString = dateTimeToDateString(wakeupTime);
    _dateToWakeupTime[dateString] = wakeupTime;
  }
  
  static DateTime? getWakeupTime(String date) {
    return _dateToWakeupTime[date];
  }
  
  static Future<void> loadWakeupTimes() async {
    final storage = await SharedPreferences.getInstance();
    final wakeupTimes = storage.getStringList('wakeupTimes');
    if (wakeupTimes == null) {
      return;
    }
    for (final wakeupTime in wakeupTimes) {
      final wakeupTimeAsDateTime = DateTime.parse(wakeupTime);
      setWakeupTime(wakeupTimeAsDateTime);
    }
  }
  
  static Future<void> saveWakeupTimes() async {
    final storage = await SharedPreferences.getInstance();
    final wakeupTimes = _dateToWakeupTime.entries.map((entry) => entry.value.toString()).toList();
    storage.setStringList('wakeupTimes', wakeupTimes);
  }
  
  /// Receives a list of dates and returns the wakeup time for each date.
  /// If no wakeup time is set for a date, it defaults to midnight.
  static List<DateTime> getWakeupTimes(List<DateTime> dates) {
    return dates.map((date) {
      final wakeupTime = getWakeupTime(dateTimeToDateString(date));
      return wakeupTime ?? DateTime(date.year, date.month, date.day);
    }).toList();
  }
}