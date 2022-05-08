import 'package:early_wakeup_stat_program/backend/wakeup_time_storage_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const epsilon = 0.00001;
  
  testWidgets('wakeup time storage util getPercentageOfDayPassed', (tester) async {
    {
      final dateTime = DateTime(2020, 1, 1, 0, 0, 0);
      final percentageOfDayPassed = WakeupTimeStorageUtil.getPercentageOfDayPassed(dateTime);
      expect(percentageOfDayPassed, closeTo(0.0, epsilon));
    }
    {
      final dateTime = DateTime(2020, 1, 1, 12, 0, 0);
      final percentageOfDayPassed = WakeupTimeStorageUtil.getPercentageOfDayPassed(dateTime);
      expect(percentageOfDayPassed, closeTo(0.5, epsilon));
    }
  });
}