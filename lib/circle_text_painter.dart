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
      double startOffset = start + end;

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

      Offset center = Offset(sizeSet, sizeSet);

      /// Calculate the circumference of the knob
      Offset circleOffset = Offset(
        sizeSet * math.cos(pi * 2 * offsetValue) + center.dx,
        sizeSet * math.sin(pi * 2 * offsetValue) + center.dy,
      );

      for (var i = 1; i <= circleTextList.length; i++) {
        double checkOffset = graphHeight * i;
        if (checkOffset + graphTextSize.height < circleLength &&
            checkOffset + graphTextSize.height < _data.circleStrokeWidth) {
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
          maxWidth: size.width,
        );

        if (startOffset < 0.25) {
          ansTex = setText(innerTextPainter, graphTextSize, ansTex, tex, true);
        } else if (startOffset > 0.25 && startOffset < 0.5) {
          ansTex = setText(innerTextPainter, graphTextSize, ansTex, tex, false);
        } else if (startOffset > 0.5 && startOffset < 0.75) {
          ansTex = setText(innerTextPainter, graphTextSize, ansTex, tex, true);
        } else if (startOffset > 0.75) {
          ansTex = setText(innerTextPainter, graphTextSize, ansTex, tex, false);
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
        maxWidth: size.width,
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

  String setText(TextPainter textPainter, Size graphTextSize, String ansTex,
      String tex, bool flg) {
    if (flg) {
      if (textPainter.width >= _data.circleStrokeWidth) {
        ansTex = ansTex.replaceFirst(tex, '${(tex).substring(0, 2)}${'...'}');
      }
      return ansTex;
    } else {
      if (textPainter.width + graphTextSize.width >= _data.circleStrokeWidth) {
        ansTex = ansTex.replaceFirst(tex, '${(tex).substring(0, 2)}${'...'}');
      }
      return ansTex;
    }
  }
}
