import 'dart:math';

import 'package:flutter/material.dart';

import 'circle_data_item.dart';

/// CircleOuterFrame is a class that sets the first week of a pie chart.
class CircleCombinedChart extends CustomPainter {
  final CircleDataItem _data;
  final double _rotate = 270;

  CircleCombinedChart(this._data);

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.restore();

    /// Size when drawing an arc.
    int len = _data.startValue?.length ?? 0;
    Paint paint = Paint()
      ..strokeWidth = _data.circleStrokeWidth
      ..style = PaintingStyle.stroke;
    canvas.rotate(degToRad(_rotate));
    canvas.translate(-size.width, 0);
    for (var i = 0; i < len; i++) {
      paint.strokeWidth = i == _data.circleTapIndex
          ? _data.circleStrokeWidth * (_data.circleTapValue ?? 1)
          : _data.circleStrokeWidth;
      paint.color = _data.circleCombinedColorList?[i] ?? Colors.white;
      canvas.drawArc(
          Rect.fromCircle(
              center: size.center(Offset.zero), radius: size.width / 2),
          (pi * 2 * (_data.startValue?[i] ?? 0.0)),
          (pi * 2 * (_data.endValue?[i] ?? 0.0)),
          false,
          paint);
    }
    canvas.save();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
