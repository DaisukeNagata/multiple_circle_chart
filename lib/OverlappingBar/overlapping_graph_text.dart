import 'dart:math';

import 'package:flutter/material.dart';

import 'overlapping_data.dart';

///　Sets the coordinate text of the graph.
class OverlappingGraphText extends CustomPainter {
  final TextStyle textStyle;
  final double boxSize;
  final int wLines;
  List<String>? valueListX;
  List<String>? valueListY;
  final Size sizeSet;
  final int graphCount;
  final double graphValue;
  final RadData? radData;
  final path = Path();
  Offset offset = Offset.zero;

  OverlappingGraphText(
      {required this.textStyle,
      required this.boxSize,
      required this.wLines,
      required this.valueListX,
      required this.valueListY,
      required this.sizeSet,
      required this.graphCount,
      required this.graphValue,
      required this.radData});

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.rotate(degToRad(radData == RadData.horizontal ? 360 : 90));

    switch (radData ?? RadData.vertical) {

      ///　Have textSpanLogic logic think about the balance of the ruled text.
      case RadData.vertical:
        for (var i = 0; i <= wLines; ++i) {
          textSpanLogic(canvas, true, i, graphCount);
        }
        for (var i = 0; i <= (graphCount); ++i) {
          textSpanLogic(canvas, false, i, graphCount);
        }
        break;

      ///　Have textSpanLogic logic think about the balance of the ruled text.
      case RadData.horizontal:
        for (var i = 0; i <= graphCount; ++i) {
          textSpanLogic(canvas, true, i, graphCount);
        }
        for (var i = 0; i <= wLines; ++i) {
          textSpanLogic(canvas, false, i, graphCount);
        }
        break;
    }
  }

  textSpanLogic(Canvas canvas, bool flg, int i, int graphCount) {
    String textValue = "";
    switch (flg) {
      case true:

        ///　Even value if it overlaps with the graph.
        if (radData == RadData.horizontal) {
          if ((valueListY?.length ?? 0) > i) {
            textValue = (valueListY?[i] ?? "");
          }
        } else {
          if ((valueListX?.length ?? 0) > i) {
            textValue = (valueListX?[i] ?? "");
          }
        }
        break;
      case false:

        ///　Even value if it overlaps with the graph.
        if (radData == RadData.horizontal) {
          if ((valueListX?.length ?? 0) > i) {
            textValue = (valueListX?[i] ?? "");
          }
        } else {
          if ((valueListY?.length ?? 0) > i) {
            textValue = (valueListY?[i] ?? "");
          }
        }
        break;
    }

    if (i <= wLines) {
      double s = boxSize;
      double s2 = sizeSet.width / wLines * i;
      final textSpan = TextSpan(
        style: textStyle,
        children: <TextSpan>[TextSpan(text: textValue)],
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: s,
      );
      double h = (textPainter.height);
      double w = (textPainter.width);
      double v = -(s * i) + s + graphValue;
      double v2 = -(s * graphCount) + graphValue;
      if (radData == RadData.horizontal) {
        /// If true, vertical line.
        if (flg) {
          offset = Offset(-s / 2, (v - h / 2));
        } else {
          offset = Offset(s2 - w / 2, s + h / 2);
        }
      } else {
        /// If true, vertical line.
        if (flg) {
          offset = Offset(v2 - w, -s2 - h / 2);
        } else {
          offset = Offset(v - w / 2, h / 2);
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
