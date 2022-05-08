import 'dart:math';

import 'package:early_wakeup_stat_program/backend/wakeup_time_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('wakeup time storage basic functionality', (tester) async {
    SharedPreferences.setMockInitialValues({});
    
    await WakeupTimeStorage.loadWakeupTimes();
    
    WakeupTimeStorage.setWakeupTime(DateTime(2020, 1, 1, 12, 0, 0));
    WakeupTimeStorage.setWakeupTime(DateTime(2020, 1, 2, 13, 0, 0));
    WakeupTimeStorage.setWakeupTime(DateTime(2020, 1, 3, 14, 0, 0));
    
    expect(WakeupTimeStorage.getWakeupTime('2020-1-1'), DateTime(2020, 1, 1, 12, 0, 0));
    expect(WakeupTimeStorage.getWakeupTime('2020-1-2'), DateTime(2020, 1, 2, 13, 0, 0));
    expect(WakeupTimeStorage.getWakeupTime('2020-1-3'), DateTime(2020, 1, 3, 14, 0, 0));
    
    await WakeupTimeStorage.saveWakeupTimes();
    
    WakeupTimeStorage.reset();
    await WakeupTimeStorage.loadWakeupTimes();
    
    expect(WakeupTimeStorage.getWakeupTime('2020-1-1'), DateTime(2020, 1, 1, 12, 0, 0));
    expect(WakeupTimeStorage.getWakeupTime('2020-1-2'), DateTime(2020, 1, 2, 13, 0, 0));
    expect(WakeupTimeStorage.getWakeupTime('2020-1-3'), DateTime(2020, 1, 3, 14, 0, 0));
  });
  
  testWidgets('wakeup time storage fuzzy test', (tester) async {
    SharedPreferences.setMockInitialValues({});
    
    final random = Random(2048802215);
    
    for (int i = 0; i < 1000; ++i) {
      WakeupTimeStorage.reset();
      
      final dateAndTimeList = List.generate(100, (index) {
        return DateTime(2020, 1, index + 1, random.nextInt(24), random.nextInt(60), random.nextInt(60));
      });
      
      for (final dateAndTime in dateAndTimeList) {
        WakeupTimeStorage.setWakeupTime(dateAndTime);
      }
      
      for (final dateAndTime in dateAndTimeList) {
        expect(WakeupTimeStorage.getWakeupTime('${dateAndTime.year}-${dateAndTime.month}-${dateAndTime.day}'), dateAndTime);
      }
      
      await WakeupTimeStorage.saveWakeupTimes();
      
      WakeupTimeStorage.reset();
      await WakeupTimeStorage.loadWakeupTimes();
      
      for (final dateAndTime in dateAndTimeList) {
        expect(WakeupTimeStorage.getWakeupTime('${dateAndTime.year}-${dateAndTime.month}-${dateAndTime.day}'), dateAndTime);
      }
    }
  });
}