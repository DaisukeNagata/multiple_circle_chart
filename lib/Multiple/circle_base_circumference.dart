import 'dart:math';

import 'package:flutter/material.dart';

/// Build a base circle design.
class CircleBaseCircumference extends CustomPainter {
  final List<Color> colors;
  final double strokeWidth;

  CircleBaseCircumference(this.colors, this.strokeWidth);

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    ///　The part you are using is a circular design.
    Paint paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(colors: colors).createShader(
        Rect.fromCircle(center: size.center(Offset.zero), radius: 0),
      );
    canvas
      ..drawCircle(size.center(Offset.zero), size.width / 2, paint)
      ..save()
      ..restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
