import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';

import 'circle_data_item.dart';

/// CircleOuterFrame is a class that sets the first week of a pie chart.
class CircleTextPainter extends CustomPainter {
  final CircleDataItem _data;

  CircleTextPainter(this._data);

  final double _correctionValue = -0.25;

  double degToRad(double deg) => deg * (pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.restore();
    double sizeSet = size.width / 2;

    /// Size when drawing an arc.
    int len = _data.startValue?.length ?? 0;
    for (var i = 0; i < len; i++) {
      Color? combinedColor = _data.circleCombinedColor?[i];
      double? textSize = _data.circleCombinedTextSize;
      String? tex = _data.circleTextList?[i];
      double start = (_data.startValue?[i] ?? 0);
      double end = (_data.endValue?[i] ?? 0) / 2;

      /// Show graph values
      TextSpan textSpan = TextSpan(children: <TextSpan>[
        TextSpan(
            text: tex,
            style: TextStyle(
                color: combinedColor,
                fontSize: textSize,
                fontWeight: FontWeight.bold)),
      ]);
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: _data.circleStrokeWidth,
      );

      List<String> circleTextList = _data.circleTextList?[i].split('\n') ?? [];
      String ansTex = "";
      double graphHeight = textPainter.height / circleTextList.length - 1;
      double offsetValue = (_correctionValue + start + end);
      Offset center = Offset(sizeSet, sizeSet);

      /// Calculate the circumference of the knob
      Offset circleOffset = Offset(
        sizeSet * math.cos(pi * 2 * offsetValue) + center.dx,
        sizeSet * math.sin(pi * 2 * offsetValue) + center.dy,
      );

      for (var i = 1; i <= circleTextList.length; i++) {
        double checkOffset = graphHeight * i;
        if (checkOffset < _data.circleStrokeWidth) {
          ansTex += '${circleTextList[i - 1]} \n';
        }
      }
      for (var tex in circleTextList) {
        TextSpan textSpan = TextSpan(children: <TextSpan>[
          TextSpan(
              text: tex,
              style: TextStyle(
                  color: combinedColor,
                  fontSize: textSize,
                  fontWeight: FontWeight.bold)),
        ]);

        TextPainter innerTextPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        innerTextPainter.layout(
          minWidth: 0,
          maxWidth: _data.circleStrokeWidth,
        );

        if (innerTextPainter.width >= _data.circleStrokeWidth) {
          ansTex = ansTex.replaceFirst(tex, '${(tex).substring(0, 2)}${'...'}');
        }
      }

      textSpan = TextSpan(children: <TextSpan>[
        TextSpan(
            text: ansTex,
            style: TextStyle(color: combinedColor, fontSize: textSize)),
      ]);
      textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(
        minWidth: 0,
        maxWidth: _data.circleStrokeWidth,
      );

      textPainter.paint(
          canvas,
          Offset(circleOffset.dx - _data.circleStrokeWidth / 4,
              circleOffset.dy - _data.circleStrokeWidth / 4));
    }
    canvas.save();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
