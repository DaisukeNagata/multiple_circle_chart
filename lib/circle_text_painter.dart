import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';

import 'circle_data_item.dart';

/// CircleOuterFrame is a class that sets the first week of a pie chart.
class CircleTextPainter extends CustomPainter {
  final CircleDataItem _data;

  CircleTextPainter(this._data);

  final double _correctionValue = -0.25;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.restore();
    double sizeSet = size.width / 2;
    Size graphTextSize = _data.graphTextSize ?? Size.zero;

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
        maxWidth: size.width,
      );

      List<String> circleTextList = _data.circleTextList?[i].split('\n') ?? [];
      String ansTex = "";
      double graphHeight = textPainter.height / circleTextList.length - 1;
      double offsetValue = (_correctionValue + start + end);
      double circleLength = (size.height * math.pi) * (_data.endValue?[i] ?? 0);
      for (var i = 1; i <= circleTextList.length; i++) {
        double checkOffset = graphHeight * i;
        if (checkOffset + graphTextSize.height < circleLength &&
            checkOffset + graphTextSize.height < _data.circleStrokeWidth) {
          ansTex += '${circleTextList[i - 1]} \n';
        } else {
          ansTex = ansTex.replaceFirst(circleTextList[i - 1],
              '${(circleTextList[i - 1]).substring(0, 2)}${'...'}');
        }
      }

      if (textPainter.width > _data.circleStrokeWidth) {
        ansTex = '...';
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
        maxWidth: size.width,
      );

      Offset center = Offset(sizeSet, sizeSet);

      /// Calculate the circumference of the knob
      Offset circleOffset = Offset(
        sizeSet * math.cos(pi * 2 * offsetValue) + center.dx,
        sizeSet * math.sin(pi * 2 * offsetValue) + center.dy,
      );

      textPainter.paint(
          canvas,
          Offset(circleOffset.dx - graphTextSize.width,
              circleOffset.dy - graphTextSize.height));
    }
    canvas.save();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
