import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:liquid_bar_chart/liquid_bar_chart/bar_data.dart';
import 'package:liquid_bar_chart/liquid_bar_chart/clipper.dart';

class LBChart extends StatelessWidget {
  List<Widget> widgetList = [];

  final List<BarData> barDataList;
  final backGroundColor;
  final title;
  final description;
  final textStyle;
  final padding;
  double waveHeight;

  LBChart({
    Key key,
    @required this.barDataList,
    this.padding,
    this.backGroundColor,
    this.title,
    this.description,
    this.textStyle,
    this.waveHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (barDataList.length < 2) {
      throw Exception("2 or more data is required");
    }

    dev.log(barDataList.length.toString());

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Center(
        child: LayoutBuilder(builder: (context, snapshot) {
          double height = snapshot.maxHeight;
          double width = snapshot.maxWidth;

          for (var barData in barDataList) {
            widgetList.add(
              WaveBar(
                barData: barData,
                height: height,
                width: width / barDataList.length,
                waveHeight: waveHeight ?? 10.0,
              ),
            );
          }

          return Column(
            children: <Widget>[
              SizedBox(
                height: title != null ? height * 0.15 : 0,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title ?? "",
                    style: textStyle ?? Theme.of(context).textTheme.title,
                  ),
                ),
              ),
              SizedBox(
                height: title != null ? height * 0.85 : height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widgetList,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class WaveBar extends StatefulWidget {
  final BarData barData;
  final height;
  final width;
  final double waveHeight;

  const WaveBar({
    Key key,
    @required this.barData,
    this.height,
    this.width,
    this.waveHeight,
  }) : super(key: key);

  @override
  _WaveBarState createState() => _WaveBarState();
}

class _WaveBarState extends State<WaveBar> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    if (widget.barData.value > widget.barData.maxValue)
      throw Exception("Do not enter a value greater than the maximum value");

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double barHeight = widget.barData.title != null
        ? widget.height * 0.7
        : widget.height * 0.85;

    double ratio = widget.barData.value / widget.barData.maxValue;
    double maxCutPoint = (barHeight - widget.width / 2) / barHeight;
    double minCutPoint = widget.width / 2 / barHeight;

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Column(
        children: <Widget>[
          Tooltip(
            message: widget.barData.toolTip,
            child: SizedBox(
              height: barHeight,
              width: widget.width,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: widget.width / 10),
                color: widget.barData.barBackColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        // if heightFactor 1, layout broken
                        heightFactor: min(ratio, maxCutPoint) < minCutPoint
                            ? 0
                            : min(ratio, maxCutPoint),
                        child: AnimatedBuilder(
                          animation: CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.linear,
                          ),
                          builder: (context, child) => ClipPath(
                            child: Card(
                              elevation: 0,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(size.width),
                                ),
                              ),
                              color: widget.barData.barColor,
                            ),
                            clipper: WaveClipper(
                              animationValue: _animationController.value,
                              ratio: widget.barData.value /
                                  widget.barData.maxValue,
                              waveHeight: widget.waveHeight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: widget.barData.title != null ? widget.height * 0.15 : 0,
            child: Align(
              alignment: Alignment.center,
              child: widget.barData.title != null
                  ? Text(
                      widget.barData.title,
                      style: widget.barData.titleTextStyle ??
                          Theme.of(context).textTheme.title,
                    )
                  : Text(""),
            ),
          ),
        ],
      ),
    );
  }
}
