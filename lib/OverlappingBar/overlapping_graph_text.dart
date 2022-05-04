import 'dart:math';

import 'package:flutter/material.dart';

import 'overlapping_data.dart';

///　Sets the coordinate text of the graph.
class OverlappingGraphText extends CustomPainter {
  final TextStyle textStyle;
  final double boxSize;
  double? offsetX;
  double? offsetY;
  double scale;
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
      required this.offsetX,
      required this.offsetY,
      required this.scale,
      required this.valueListX,
      required this.valueListY,
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
          textSpanLogic(canvas, true, i, wLines, graphCount);
        }
        for (var i = 0; i <= (graphCount); ++i) {
          textSpanLogic(canvas, false, i, (graphCount), graphCount);
        }
        break;

      ///　Have textSpanLogic logic think about the balance of the ruled text.
      case RadData.horizontal:
        for (var i = 0; i <= (graphCount); ++i) {
          textSpanLogic(canvas, true, i, (graphCount), graphCount);
        }
        for (var i = 0; i <= wLines; ++i) {
          textSpanLogic(canvas, false, i, wLines, graphCount);
        }
        break;
    }
  }

  textSpanLogic(Canvas canvas, bool flg, int i, int wLines, int graphCount) {
    String textValue = "";
    double s = (boxSize * scale);
    double sizeWidth = sizeSet.width / wLines * i;
    double horizonalLineX = (graphValue > 20 ? 1 : 1.25);
    double horizonalLineY = 2.5;
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

      if (radData == RadData.horizontal) {
        /// If true, vertical line.
        if (flg) {
          offset = Offset(
              offsetX ?? 0,
              (-(s * i) +
                  s +
                  graphValue / 2 -
                  textPainter.height / horizonalLineY));
        } else {
          offset = Offset(sizeWidth - textPainter.width / 2, s + s / 2);
        }
      } else {
        /// If true, vertical line.
        if (flg) {
          offset = Offset(
              -(s * (graphCount + horizonalLineX)) +
                  s +
                  graphValue / 2 -
                  textPainter.width / 2,
              -sizeWidth - (offsetY ?? 0) / 2);
        } else {
          offset = Offset(-(s * i) + s + graphValue / 2 - textPainter.width / 2,
              (offsetY ?? 0) / 2);
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
