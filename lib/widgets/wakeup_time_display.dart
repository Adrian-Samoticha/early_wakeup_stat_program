import 'package:early_wakeup_stat_program/backend/wakeup_time_storage_util.dart';
import 'package:early_wakeup_stat_program/date_to_color.dart';
import 'package:flutter/material.dart';

class WakeupTimeColumn extends StatelessWidget {
  const WakeupTimeColumn({Key? key, required this.wakeupTime}) : super(key: key);
  
  final DateTime wakeupTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _generateColumn(),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: _generateTextRow(),
          ),
        ],
      ),
    );
  }
  
  Widget _generateColumn() {
    return Stack(
      children: [
        _generateColumnBackground(),
        _generateColumnForeground(),
      ]
    );
  }
  
  Widget _generateColumnBackground() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.1),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
  
  Widget _generateColumnForeground() {
    final percentageOfDayPassed = WakeupTimeStorageUtil.getPercentageOfDayPassed(wakeupTime);
    final color = DateToColor.getColorFromDateTime(wakeupTime);
    
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: percentageOfDayPassed,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          )
        ),
      ),
    );
  }
  
  bool _isMidnight(DateTime dateTime) {
    return dateTime.hour == 0 && dateTime.minute == 0 && dateTime.second == 0;
  }
  
  Widget _generateTextRow() {
    final isMidnight = _isMidnight(wakeupTime);
    
    final dateString = wakeupTime.toString().split(' ')[0];
    final timeString = isMidnight ? '' : wakeupTime.toString().split(' ')[1].split('.')[0];
    
    return Opacity(
      opacity: isMidnight ? 0.5 : 0.7,
      child: Row(
        children: [
          Text(dateString),
          const Spacer(),
          Text(timeString),
        ],
      ),
    );
  }
}

class WakeupTimeDisplay extends StatelessWidget {
  const WakeupTimeDisplay({Key? key, required this.wakeupTimes}) : super(key: key);
  
  final List<DateTime> wakeupTimes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Row(
        children: wakeupTimes.map((e) {
          return Expanded(
            child: WakeupTimeColumn(wakeupTime: e)
          );
        }).toList(),
      ),
    );
  }
}