import 'dart:math';

import 'package:flutter/material.dart';

import 'overlapping_data.dart';

///　Sets the coordinate text of the graph.
class OverlappingGraphText extends CustomPainter {
  final TextStyle textStyle;
  final double boxSize;
  double? offsetX = -25;
  double? offsetY = 20;
  double? textValue;
  final Size sizeSet;
  final int graphCount;
  final double graphValue;
  final RadData? radData;
  final path = Path();
  Offset offset = Offset.zero;

  OverlappingGraphText(
      {required this.textStyle,
      required this.boxSize,
      double? offsetX,
      double? offsetY,
      required this.textValue,
      required this.sizeSet,
      required this.graphCount,
      required this.graphValue,
      required this.radData});

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    final wLines = (sizeSet.width ~/ boxSize);

    canvas.rotate(degToRad(radData == RadData.horizontal ? 360 : 90));

    switch (radData ?? RadData.vertical) {

      ///　Have textSpanLogic logic think about the balance of the ruled text.
      case RadData.vertical:
        for (var i = 0; i <= wLines; ++i) {
          double y = -(textValue ?? 0) * i;
          textSpanLogic(canvas, true, i, wLines, graphCount, value: y);
        }
        for (var i = 0; i <= (graphCount * 2) + 1; ++i) {
          final x = (textValue ?? 0) * i;
          textSpanLogic(canvas, false, i, (graphCount * 2), graphCount,
              value: x);
        }
        break;

      ///　Have textSpanLogic logic think about the balance of the ruled text.
      case RadData.horizontal:
        for (var i = 0; i <= (graphCount * 2); ++i) {
          double y = -(textValue ?? 0) * i;
          textSpanLogic(canvas, true, i, (graphCount * 2), graphCount,
              value: y);
        }
        for (var i = 0; i <= wLines; ++i) {
          final x = (textValue ?? 0) * i;
          textSpanLogic(canvas, false, i, wLines, graphCount, value: x);
        }
        break;
    }
  }

  textSpanLogic(Canvas canvas, bool flg, int i, int wLines, int graphCount,
      {double? value}) {
    int? textSetValue = flg ? (value?.toInt() ?? 0) * -1 : value?.toInt();
    if (i <= wLines) {
      final textSpan = TextSpan(
        style: textStyle,
        children: <TextSpan>[TextSpan(text: '$textSetValue')],
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
          offset = Offset(offsetX ?? 0, (boxSize + (-boxSize * i)));
        } else {
          offset = Offset(sizeSet.width / wLines * i, boxSize + (offsetY ?? 0));
        }
      } else {
        if (flg) {
          offset = Offset(-boxSize * (graphCount * 2) - (offsetX ?? 0),
              -sizeSet.width / wLines * i - graphValue);
        } else {
          offset = Offset(
              -(boxSize * (wLines - 1) - graphValue) + (boxSize * i),
              (offsetY ?? 0));
        }
      }

      if (i > 0 && (textSetValue ?? 0) != 0.0) {
        textPainter.paint(canvas, offset);
      } else if (i == 0 && (textSetValue ?? 0) == 0.0 && textValue != 0) {
        textPainter.paint(canvas, offset);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
