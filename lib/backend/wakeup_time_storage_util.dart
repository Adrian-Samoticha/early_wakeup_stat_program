class WakeupTimeStorageUtil {
  /// Receives a [DateTime] object and returns the percentage of the day that has passed.
  static double getPercentageOfDayPassed(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final second = dateTime.second;
    
    final totalSeconds = hour * 3600 + minute * 60 + second;
    const totalSecondsInDay = 24 * 3600;
    
    return totalSeconds / totalSecondsInDay;
  }
}