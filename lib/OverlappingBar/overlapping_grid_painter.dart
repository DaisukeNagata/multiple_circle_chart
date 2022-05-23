import 'dart:math';

import 'package:flutter/material.dart';

import 'overlapping_data.dart';

///　Set the ruled line of the graph.
class OverlappingGridPainter extends CustomPainter {
  final TextStyle textStyle;
  final double boxSize;
  final int wLines;
  final double strokeWidth;
  final bool checkLine;
  final bool baseLine;
  final Size sizeSet;
  final Color colorSet;
  final double graphValue;
  final RadData? radData;
  final path = Path();
  Offset offset = Offset.zero;

  OverlappingGridPainter(
      {required this.textStyle,
      required this.boxSize,
      required this.wLines,
      required this.strokeWidth,
      required this.checkLine,
      required this.baseLine,
      required this.sizeSet,
      required this.colorSet,
      required this.graphValue,
      required this.radData});

  Paint paintSet = Paint();

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    paintSet = Paint()
      ..strokeWidth = strokeWidth
      ..color = colorSet.withOpacity(strokeWidth == 0 ? 0 : 1)
      ..style = PaintingStyle.stroke;

    ///　A value of 2 will balance the ruled lines.
    ///　Have textSpanLogic logic think about the balance of the ruled lines.
    for (var i = 0; i <= 2; ++i) {
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
      pathSet(value, flg, i, wLines);
    } else {
      ///　Confirmation from top to bottom.
      ///　In that case, draw a line.
      pathSet(value, flg, i, wLines);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  pathSet(double value, bool flg, int i, int wLines) {
    var h = boxSize + graphValue;
    var h2 = -boxSize * 2 + graphValue;
    var c = checkLine && baseLine && i == 0;
    var c2 = checkLine && !baseLine && i == 2;
    if (flg) {
      ///　Confirmation from top to bottom.
      ///　In that case, draw a line.
      if (c) {
        ///　most bottom area point.
        path.moveTo(0, value + boxSize);
        path.relativeLineTo(sizeSet.width, 0);
      } else if (c2) {
        ///　most top area point.
        path.moveTo(0, value + boxSize + graphValue * 2);
        path.relativeLineTo(sizeSet.width, 0);
      }
    } else {
      /// Draw the X-axis sideways.
      path.moveTo(sizeSet.width / wLines * i, h - graphValue);
      path.relativeLineTo(0, h2 + graphValue);
    }
  }
}
