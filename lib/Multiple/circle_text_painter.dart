import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multiple_circle_chart/Multiple/circle_data_item.dart';

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
    _data.circleTextSizeList = _data.circleTextSizeList ?? [];

    /// Size when drawing an arc.
    int len = _data.startValue?.length ?? 0;
    for (var i = 0; i < len; i++) {
      Color? combinedColor = _data.circleCombinedColor?[i];
      double? textSize = _data.circleCombinedTextSize;
      String? tex = _data.circleTextList?[i];
      double start = (_data.startValue?[i] ?? 0);
      double end = (_data.endValue?[i] ?? 0) / 2;
      int lenIndex = i;

      /// Show graph values
      TextSpan textSpan = TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: tex,
            style: TextStyle(
              color: combinedColor,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: _data.circleStrokeWidth,
      );

      _data.circleTextSizeList?.add(textPainter.size);

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

      ///　Sets character data.
      for (var i = 1; i <= circleTextList.length; i++) {
        double checkOffset = graphHeight * i;
        if (checkOffset + (_data.circleTextMarginList?[lenIndex].height ?? 0) <
            _data.circleStrokeWidth) {
          ansTex += '${circleTextList[i - 1]} \n';
        }
      }

      for (var tex in circleTextList) {
        TextSpan textSpan = TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: tex,
              style: TextStyle(
                color: combinedColor,
                fontSize: textSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );

        TextPainter innerTextPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );

        /// The character position is within the width of the circle.
        innerTextPainter.layout(
          minWidth: 0,
          maxWidth: _data.circleStrokeWidth,
        );

        /// I'm doing a character-by-character calculation.
        /// Suppose that beyond the realm...
        if (innerTextPainter.width >=
            ((size.width * math.pi)) * ((_data.endValue?[i] ?? 0))) {
          ansTex = ansTex.replaceFirst(tex, '${(tex).substring(0, 2)}${'...'}');
        }
      }

      textSpan = TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: ansTex,
            style: TextStyle(color: combinedColor, fontSize: textSize),
          ),
        ],
      );
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
        Offset(
          circleOffset.dx - (_data.circleTextMarginList?[i].width ?? 0),
          circleOffset.dy - (_data.circleTextMarginList?[i].height ?? 0),
        ),
      );
    }
    canvas.save();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
