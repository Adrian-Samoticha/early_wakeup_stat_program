import 'package:flutter/material.dart';

class ConfirmWakeupButton extends StatelessWidget {
  const ConfirmWakeupButton({Key? key, required this.onPressed, required this.isConfirmed, required this.now, required this.wakeupTime}) : super(key: key);
  
  final void Function() onPressed;
  final bool isConfirmed;
  final DateTime now;
  final DateTime? wakeupTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Center(
        child: OutlinedButton(
          onPressed: isConfirmed ? null : onPressed,
          child: Text(_buttonText),
        ),
      ),
    );
  }
  
  String get _buttonText {
    if (isConfirmed) {
      return 'Confirmed wakeup at ${_getTimeOfDayFromDateTime(wakeupTime!)}';
    }
    return 'Confirm wakeup at ${_getTimeOfDayFromDateTime(now)}';
  }
  
  String _getTimeOfDayFromDateTime(DateTime dateTime) {
    final dateTimeAsString = dateTime.toString();
    final dateTimeAsStringWithoutDate = dateTimeAsString.split(' ')[1];
    final dateTimeAsStringWithoutMilliseconds = dateTimeAsStringWithoutDate.split('.')[0];
    
    return dateTimeAsStringWithoutMilliseconds;
  }
}