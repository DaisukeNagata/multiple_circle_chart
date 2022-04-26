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
        i <= (radData == RadData.horizontal ? (graphCount * 2) + 1 : wLines);
        ++i) {
      double y = -boxSize * i;
      textSpanLogic(
          canvas,
          y,
          true,
          i,
          (radData == RadData.horizontal ? (graphCount * 2) : wLines),
          graphCount);
    }

    for (var i = 0;
        i <= (radData == RadData.vertical ? (graphCount * 2) + 1 : wLines);
        ++i) {
      final x = boxSize * i;
      textSpanLogic(
          canvas,
          x,
          false,
          i,
          (radData == RadData.vertical ? (graphCount * 2) : wLines),
          graphCount);
    }
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = colorSet
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  textSpanLogic(Canvas canvas, double value, bool flg, int i, int wLines,
      int graphCount) {
    double textValue = flg ? value * -1 : value;
    if (i <= wLines) {
      final textSpan = TextSpan(
        style: textStyle,
        children: <TextSpan>[TextSpan(text: '$textValue')],
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: boxSize,
      );

      if (radData == RadData.horizontal) {
        if (flg) {
          offset = Offset(offsetX, (boxSize + value));
        } else {
          offset = Offset(sizeSet.width / wLines * i, boxSize + offsetY);
        }
      } else {
        if (flg) {
          offset = Offset(-boxSize * (graphCount * 2) - offsetX,
              -sizeSet.width / wLines * i - 7.5);
        } else {
          offset = Offset(-(boxSize * (wLines - 1) - 7.5) + value, offsetY);
        }
      }
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
