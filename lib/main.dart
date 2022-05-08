import 'dart:async';

import 'package:early_wakeup_stat_program/backend/wakeup_time_storage.dart';
import 'package:early_wakeup_stat_program/date_to_color.dart';
import 'package:early_wakeup_stat_program/widgets/confirm_wakeup_button.dart';
import 'package:early_wakeup_stat_program/widgets/wakeup_time_display.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: DateToColor.getColorFromDateTime(DateTime.now()),
      ),
      darkTheme: ThemeData(
        primarySwatch: DateToColor.getColorFromDateTime(DateTime.now()),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Timer _secondTimer;
  DateTime _now = DateTime.now();
  DateTime? _wakeupTime;
  List<DateTime> _wakeupTimes = [];
  int _wakeupTimesOffsetInDays = 0;
  
  
  @override
  void initState() {
    super.initState();
    
    _secondTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
    
    _initWakeupTimeStorage();
  }
  
  Future<void> _initWakeupTimeStorage() async {
    await WakeupTimeStorage.loadWakeupTimes();
    setState(() {
      _setWakeupTimes();
      _setWakeupTime();
    });
  }
  
  void _setWakeupTimes() {
    final now = DateTime.now();
    
    final dates = List.generate(7, (index) {
      return now.subtract(Duration(days: _wakeupTimesOffsetInDays + index));
    }).reversed.toList();
    
    _wakeupTimes = WakeupTimeStorage.getWakeupTimes(dates);
  }
  
  void _setWakeupTime() {
    final now = DateTime.now();
    final dateString = WakeupTimeStorage.dateTimeToDateString(now);
    _wakeupTime = WakeupTimeStorage.getWakeupTime(dateString);
  }
  
  @override
  void dispose() {
    _secondTimer.cancel();
    
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: WakeupTimeDisplay(
              wakeupTimes: _wakeupTimes,
            ),
          ),
          ConfirmWakeupButton(
            onPressed: () {
              setState(() {
                WakeupTimeStorage.setWakeupTime(_now);
                
                _setWakeupTimes();
                _setWakeupTime();
                
                WakeupTimeStorage.saveWakeupTimes();
              });
            },
            isConfirmed: _wakeupTime != null,
            now: _now,
            wakeupTime: _wakeupTime,
          ),
        ]
      ),
    );
  }
}
