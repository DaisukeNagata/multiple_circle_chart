import 'dart:math';

import 'package:flutter/material.dart';

import 'overlapping_data.dart';

class OverlappingGridPainter extends CustomPainter {
  final TextStyle textStyle;
  final double boxSize;
  final double strokeWidth;
  final double offsetX;
  final double offsetY;
  final Size sizeSet;
  final Color colorSet;
  final RadData? radData;
  final path = Path();
  Offset offset = Offset.zero;

  OverlappingGridPainter(this.textStyle, this.boxSize, this.strokeWidth,
      this.offsetX, this.offsetY, this.sizeSet, this.colorSet, this.radData);

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    final wLines = (sizeSet.width ~/ boxSize);

    for (var i = 0; i <= 2; ++i) {
      final y = -boxSize * i;
      textSpanLogic(y, true, i, wLines);
    }

    for (var i = 0; i <= wLines; ++i) {
      final x = boxSize * i;
      textSpanLogic(x, false, i, wLines);
    }
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = colorSet
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  textSpanLogic(double value, bool flg, int i, int wLines) {
    if (radData == RadData.horizontal) {
      if (flg) {
        path.moveTo(0, value + boxSize + 7.5);
        path.relativeLineTo(sizeSet.width, 0);
      } else {
        path.moveTo(sizeSet.width / wLines * i, boxSize + 7.5);
        path.relativeLineTo(0, -boxSize * 2);
      }
    } else {
      if (flg) {
        path.moveTo(0, value + boxSize + 7.5);
        path.relativeLineTo(sizeSet.width, 0);
      } else {
        path.moveTo(sizeSet.width / wLines * i, boxSize + 7.5);
        path.relativeLineTo(0, -boxSize * 2);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
