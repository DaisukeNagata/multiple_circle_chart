import 'dart:math';

import 'package:flutter/material.dart';

import 'overlapping_data.dart';

///　Set the ruled line of the graph.
class OverlappingGridPainter extends CustomPainter {
  final TextStyle textStyle;
  final double boxSize;
  final double strokeWidth;
  double? offsetX = -25;
  double? offsetY = 20;
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
      required this.strokeWidth,
      double? offsetX,
      double? offsetY,
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
    final wLines = (sizeSet.width ~/ boxSize);
    paintSet = Paint()
      ..strokeWidth = strokeWidth
      ..color = colorSet.withOpacity(strokeWidth == 0 ? 0 : 1)
      ..style = PaintingStyle.stroke;

    ///　A value of 2 will balance the ruled lines.
    ///　Have textSpanLogic logic think about the balance of the ruled lines.
    for (var i = 0; i <= 2; ++i) {
      final y = -boxSize * i;
      textSpanLogic(y, true, i, wLines);
    }

    ///　Have textSpanLogic logic think about the balance of the ruled lines.
    for (var i = 0; i <= wLines; ++i) {
      final x = boxSize * i;
      textSpanLogic(x, false, i, wLines);
    }
    canvas.drawPath(path, paintSet);
  }

  textSpanLogic(double value, bool flg, int i, int wLines) {
    var h = boxSize + graphValue;
    var h2 = -boxSize * 2;
    var c = checkLine && baseLine && i == 0;
    var c2 = checkLine && !baseLine && i == 2;
    if (radData == RadData.horizontal) {
      if (flg) {
        if (c || c2) {
          path.moveTo(0, value + boxSize + graphValue);
          path.relativeLineTo(sizeSet.width, 0);
        } else {
          path.moveTo(0, 0);
          path.relativeLineTo(0, 0);
        }
      } else {
        path.moveTo(sizeSet.width / wLines * i, h);
        path.relativeLineTo(0, h2);
      }
    } else {
      if (flg) {
        if (c || c2) {
          path.moveTo(0, value + boxSize + graphValue);
          path.relativeLineTo(sizeSet.width, 0);
        } else {
          path.moveTo(0, 0);
          path.relativeLineTo(0, 0);
        }
      } else {
        path.moveTo(sizeSet.width / wLines * i, boxSize + graphValue);
        path.relativeLineTo(0, -boxSize * 2);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
