import 'dart:math';

import 'package:flutter/material.dart';

import 'overlapping_data.dart';

///　Sets the coordinate text of the graph.
class OverlappingGraphText extends CustomPainter {
  final TextStyle textStyle;
  final double boxSize;
  double? offsetX = -25;
  double? offsetY = 20;
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
      double? offsetX,
      double? offsetY,
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
        for (var i = 0; i <= (graphCount * 2) + 1; ++i) {
          textSpanLogic(canvas, false, i, (graphCount * 2), graphCount);
        }
        break;

      ///　Have textSpanLogic logic think about the balance of the ruled text.
      case RadData.horizontal:
        for (var i = 0; i <= (graphCount * 2); ++i) {
          textSpanLogic(canvas, true, i, (graphCount * 2), graphCount);
        }
        for (var i = 0; i <= wLines; ++i) {
          textSpanLogic(canvas, false, i, wLines, graphCount);
        }
        break;
    }
  }

  textSpanLogic(Canvas canvas, bool flg, int i, int wLines, int graphCount) {
    String textValue = "";
    switch (flg) {
      case true:
        if (radData == RadData.horizontal) {
          if ((valueListY?.length ?? 0) > i) {
            textValue = i % 2 == 0 ? "" : (valueListY?[i] ?? "");
          }
        } else {
          if ((valueListX?.length ?? 0) > i) {
            textValue = (valueListX?[i] ?? "");
          }
        }
        break;
      case false:
        if (radData == RadData.horizontal) {
          if ((valueListX?.length ?? 0) > i) {
            textValue = (valueListX?[i] ?? "");
          }
        } else {
          if ((valueListY?.length ?? 0) > i) {
            textValue = i % 2 == 0 ? "" : (valueListY?[i] ?? "");
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
        maxWidth: boxSize,
      );

      if (radData == RadData.horizontal) {
        if (flg) {
          offset = Offset(offsetX ?? 0, (boxSize + (-boxSize * i)));
        } else {
          offset = Offset(sizeSet.width / wLines * i - textPainter.width / 2,
              boxSize + (offsetY ?? 0));
        }
      } else {
        if (flg) {
          offset = Offset(-boxSize * (graphCount * 2) - (offsetX ?? 0),
              -sizeSet.width / wLines * i - graphValue);
        } else {
          offset = Offset(
              -(boxSize * (wLines - 1) - graphValue) +
                  (boxSize * i) -
                  textPainter.width / 2,
              (offsetY ?? 0));
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
