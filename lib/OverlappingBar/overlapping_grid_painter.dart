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
      required this.sizeSet,
      required this.colorSet,
      required this.graphValue,
      required this.radData});

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    final wLines = (sizeSet.width ~/ boxSize);

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
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = colorSet.withOpacity(strokeWidth == 0 ? 0 : 1)
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  textSpanLogic(double value, bool flg, int i, int wLines) {
    if (radData == RadData.horizontal) {
      if (flg) {
        path.moveTo(0, value + boxSize + graphValue);
        path.relativeLineTo(sizeSet.width, 0);
      } else {
        path.moveTo(sizeSet.width / wLines * i, boxSize + graphValue);
        path.relativeLineTo(0, -boxSize * 2);
      }
    } else {
      if (flg) {
        path.moveTo(0, value + boxSize + graphValue);
        path.relativeLineTo(sizeSet.width, 0);
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
