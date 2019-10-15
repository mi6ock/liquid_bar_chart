import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_bar_chart/liquid_bar_chart.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChartExample(),
    ),
  );
}

class ChartExample extends StatefulWidget {
  @override
  _ChartExampleState createState() => _ChartExampleState();
}

class _ChartExampleState extends State<ChartExample> {
  List<BarData> barDataList = [];
  final List<String> week = ["Sun", "Mon", "Thu", "Wed", "Thu", "Fri", "Sat"];
  final List<String> tooltips = [
    "Good",
    "Bad",
    "So So",
    "A little nice",
    "Pretty good",
    "Very good",
    "Super nice"
  ];

  @override
  void initState() {
    super.initState();
    _createData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chart Example"),
      ),
      body: Center(
        child: SizedBox(
          height: size.height / 2,
          width: size.width,
          child: Card(
            margin: const EdgeInsets.all(18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.blueGrey[100],
            child: LBChart(
              barDataList: barDataList,
              padding: EdgeInsets.all(8),
              title: "Chart Title",
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createData(),
      ),
    );
  }

  void _createData() {
    Random rnd = Random();
    barDataList = [];
    for (int i = 0; i < 7; i++) {
      barDataList.add(
        BarData(
          value: rnd.nextDouble() * 10,
          maxValue: 10,
          barBackColor: Colors.blue[100],
          barColor: Colors.blue,
          title: week[i],
          toolTip: tooltips[i],
        ),
      );
      setState(() {});
    }
  }
}
