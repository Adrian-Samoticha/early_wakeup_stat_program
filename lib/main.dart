import 'dart:async';

import 'package:early_wakeup_stat_program/date_to_color.dart';
import 'package:early_wakeup_stat_program/widgets/confirm_wakeup_button.dart';
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
  bool _isConfirmed = false;
  late Timer _secondTimer;
  DateTime _now = DateTime.now();
  DateTime? _wakeupTime;
  
  
  @override
  void initState() {
    super.initState();
    
    _secondTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _now = DateTime.now();
      });
    });
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
            child: Container(),
          ),
          ConfirmWakeupButton(
            onPressed: () {
              setState(() {
                _isConfirmed = true;
                _wakeupTime = _now;
              });
            },
            isConfirmed: _isConfirmed,
            now: _now,
            wakeupTime: _wakeupTime,
          ),
        ]
      ),
    );
  }
}
