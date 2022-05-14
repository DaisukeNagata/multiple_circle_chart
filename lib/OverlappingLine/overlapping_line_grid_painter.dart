import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';

class OverlappingLineGridPainter extends CustomPainter {
  final TextStyle textStyle;
  final double boxSize;
  final int wLines;
  final double strokeWidth;
  final Size sizeSet;
  final Color colorSet;
  final RadData? radData;
  final path = Path();
  Offset offset = Offset.zero;

  OverlappingLineGridPainter(
      {required this.textStyle,
      required this.boxSize,
      required this.wLines,
      required this.strokeWidth,
      required this.sizeSet,
      required this.colorSet,
      required this.radData});

  Paint paintSet = Paint();

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    paintSet = Paint()
      ..strokeWidth = strokeWidth
      ..color = colorSet.withOpacity(strokeWidth == 0 ? 0 : 1)
      ..style = PaintingStyle.stroke;

    ///　A value of 1 will balance the ruled lines.
    ///　Have textSpanLogic logic think about the balance of the ruled lines.
    for (var i = 0; i <= 1; ++i) {
      final y = -boxSize * i;
      textSpanLogic(y, true, i);
    }

    ///　Have textSpanLogic logic think about the balance of the ruled lines.
    for (var i = 0; i <= wLines; ++i) {
      final x = boxSize * i;
      textSpanLogic(x, false, i);
    }
    canvas.drawPath(path, paintSet);
  }

  textSpanLogic(double value, bool flg, int i) {
    if (radData == RadData.horizontal) {
      ///　Confirmation from top to bottom.
      ///　In that case, draw a line.
      for (var i = 0; i <= wLines; ++i) {
        pathSet(value, flg, i);
      }
    } else {
      ///　Confirmation from top to bottom.
      ///　In that case, draw a line.
      for (var i = 0; i <= wLines; ++i) {
        pathSet(value, flg, i);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  pathSet(double value, bool flg, int i) {
    var h = boxSize * wLines;
    var h2 = -boxSize * wLines;
    if (flg) {
      ///　Confirmation from top to bottom.
      ///　In that case, draw a line.
      path.moveTo(0, boxSize * i);
      path.relativeLineTo(sizeSet.width, 0);
    } else {
      /// Draw the X-axis sideways.
      path.moveTo(sizeSet.width / wLines * i, h);
      path.relativeLineTo(0, h2);
    }
  }
}
