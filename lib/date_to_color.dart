import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

class DateToColor {
  static List<MaterialColor?> colors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  
  static MaterialColor? getColorFromDateTime(DateTime date) {
    final day = date.day;
    final month = date.month;
    final year = date.year;
    
    final hashCode = hash2(day, hash2(month, year));
    
    return colors[hashCode % colors.length];
  }
}