import 'dart:math' as math;

import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final double animationValue;
  final double ratio;
  final double waveHeight;

  WaveClipper({
    @required this.animationValue,
    @required this.ratio,
    @required this.waveHeight,
  });

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addPolygon(_wave(size), false)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..close();
    return path;
  }

  List<Offset> _wave(Size size) {
    double dim = 180;
    if (size.width < 50) {
      dim = 90;
    }

    final waves = <Offset>[];
    for (int i = -10; i <= size.width.toInt() + 10; i++) {
      final y = math.sin(
                (animationValue * 360 - i * 2) % 360 * (math.pi / dim),
              ) *
              waveHeight +
          waveHeight;
      waves.add(Offset(i.toDouble(), y));
    }
    return waves;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animationValue != oldClipper.animationValue;
}
