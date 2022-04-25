import 'dart:math';

import 'package:flutter/material.dart';

import 'overlapping_data.dart';

class OverlappingGraphText extends CustomPainter {
  final TextStyle textStyle;
  final double boxSize;
  final double strokeWidth;
  final double offsetX;
  final double offsetY;
  final Size sizeSet;
  final int graphCount;
  final Color colorSet;
  final RadData? radData;
  final path = Path();
  Offset offset = Offset.zero;

  OverlappingGraphText(
      this.textStyle,
      this.boxSize,
      this.strokeWidth,
      this.offsetX,
      this.offsetY,
      this.sizeSet,
      this.graphCount,
      this.colorSet,
      this.radData);

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    final wLines = (sizeSet.width ~/ boxSize);

    canvas.rotate(degToRad(radData == RadData.horizontal ? 360 : 90));
    for (var i = 0;
        i <= (radData == RadData.horizontal ? graphCount * 2 : wLines);
        ++i) {
      final y = -boxSize * i;
      textSpanLogic(canvas, y, true, i, wLines);
    }

    for (var i = 0;
        i <= (radData == RadData.vertical ? graphCount * 2 : wLines);
        ++i) {
      final x = boxSize * i;
      textSpanLogic(canvas, x, false, i, wLines);
    }
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = colorSet
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  textSpanLogic(Canvas canvas, double value, bool flg, int i, int wLines) {
    if (i <= wLines) {
      final textSpan = TextSpan(
        style: textStyle,
        children: <TextSpan>[
          TextSpan(text: '${value >= 0 ? value : value * -1}')
        ],
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.rtl,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: boxSize,
      );

      if (radData == RadData.horizontal) {
        if (flg) {
          offset = Offset(offsetX, (boxSize + value));
        } else {
          offset = Offset(value, boxSize + offsetY);
        }
      } else {
        if (flg) {
          offset = Offset(offsetX * wLines, value);
        } else {
          offset = Offset(value + offsetX * (wLines - 1), offsetY);
        }
      }
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
