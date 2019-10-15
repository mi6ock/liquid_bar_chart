import 'package:flutter/material.dart';

class BarData {
  /// chart bar value
  final double value;

  /// chart bar max value (value <= maxValue)
  final double maxValue;

  final Color barBackColor;
  final Color barColor;

  final String title;
  final TextStyle titleTextStyle;
  final String toolTip;

  ///default 4
  final elevation;

  const BarData({
    Key key,
    @required this.value,
    @required this.maxValue,
    @required this.barBackColor,
    @required this.barColor,
    @required this.title,
    @required this.toolTip,
    this.elevation,
    this.titleTextStyle,
  });

  @override
  String toString() {
    return 'BarData{value: $value, maxValue: $maxValue, '
        'barBackColor: $barBackColor, barColor: $barColor, '
        'title: $title, toolTip: $toolTip}';
  }
}
