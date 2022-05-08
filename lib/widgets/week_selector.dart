import 'package:flutter/material.dart';

class WeekSelector extends StatelessWidget {
  const WeekSelector({Key? key, required this.wakeupTimesOffsetInDays, required this.onWeekChanged}) : super(key: key);
  
  final int wakeupTimesOffsetInDays;
  final void Function(int) onWeekChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 40.0,
        child: _generateRow(),
      ),
    );
  }
  
  Widget _generateRow() {
    return Row(
      children: [
        _generatePreviousWeekButton(),
        Expanded(child: _generateText()),
        _generateNextWeekButton(),
      ],
    );
  }
  
  Widget _generatePreviousWeekButton() {
    return IconButton(
      icon: const Icon(Icons.chevron_left),
      onPressed: () {
        onWeekChanged(wakeupTimesOffsetInDays + 7);
      },
    );
  }
  
  Widget _generateNextWeekButton() {
    return IconButton(
      icon: const Icon(Icons.chevron_right),
      onPressed:wakeupTimesOffsetInDays == 0 ? null : () {
        onWeekChanged(wakeupTimesOffsetInDays - 7);
      },
    );
  }
  
  String _getDaysAgoText(int daysAgo) {
    if (daysAgo == 0) {
      return 'today';
    }
    
    return '$daysAgo days ago';
  }
  
  Widget _generateText() {
    return Opacity(
      opacity: 0.8,
      child: Center(
        child: Text(
          '${_getDaysAgoText(wakeupTimesOffsetInDays + 7)} to ${_getDaysAgoText(wakeupTimesOffsetInDays)}',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}