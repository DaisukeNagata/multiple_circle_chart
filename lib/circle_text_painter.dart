import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';

import 'circle_data_item.dart';

/// CircleOuterFrame is a class that sets the first week of a pie chart.
class CircleTextPainter extends CustomPainter {
  final CircleDataItem _data;

  CircleTextPainter(this._data);

  final double _correctionValue = 0.25;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.restore();
    double sizeSet = size.width / 2;

    /// Size when drawing an arc.
    int len = _data.startValue?.length ?? 0;
    for (var i = 0; i < len; i++) {
      /// Show graph values
      TextSpan textSpan = TextSpan(children: <TextSpan>[
        TextSpan(
            text: _data.circleTextList?[i],
            style: TextStyle(
                color: _data.circleCombinedColor?[i],
                fontSize: _data.circleCombinedTextSize)),
      ]);
      TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      double graphHeight =
          (size.height * math.pi) * (_data.startValue?[i] ?? 0);
      double marginHeight =
          graphHeight - (size.height * math.pi) * (_data.endValue?[i] ?? 0) / 2;

      if ((graphHeight < textPainter.height + marginHeight ||
          _data.circleStrokeWidth <
              textPainter.height + (_data.circlePointerValue ?? 0) / 2)) {
        var matchedIndex = i;
        var checkIndex = 0;
        List<String> tex = _data.circleTextList?[i].split('\n') ?? [];
        double arrayIndex = textPainter.height / tex.length;
        String ansTex = "";

        for (var i = 1; i <= tex.length; i++) {
          if (arrayIndex * i + (_data.circlePointerValue ?? 0) / 2 <
                  size.height *
                      (_data.endValue?[matchedIndex] ?? 0) *
                      math.pi &&
              arrayIndex * i + (_data.circlePointerValue ?? 0) / 2 <
                  _data.circleStrokeWidth) {
            ansTex += '${tex[i - 1]} \n';
            checkIndex = i - 1;
          } else {
            ansTex = ansTex.replaceFirst(tex[checkIndex],
                '${(tex[checkIndex]).substring(0, 2)}${'...'}');
          }
        }
        textSpan = TextSpan(children: <TextSpan>[
          TextSpan(
              text: ansTex,
              style: TextStyle(
                  color: _data.circleCombinedColor?[i],
                  fontSize: _data.circleCombinedTextSize)),
        ]);
        textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
      }

      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      Offset center = Offset(sizeSet, sizeSet);

      /// Calculate the circumference of the knob
      Offset circleOffset = Offset(
        sizeSet *
                math.cos(pi * 2 * (_data.startValue?[i] ?? 0) +
                    pi * 2 * (_data.endValue?[i] ?? 0) / 2 -
                    (pi * 2 * _correctionValue)) +
            center.dx,
        sizeSet *
                math.sin(pi * 2 * (_data.startValue?[i] ?? 0) +
                    pi * 2 * (_data.endValue?[i] ?? 0) / 2 -
                    (pi * 2 * _correctionValue)) +
            center.dy,
      );

      textPainter.paint(
          canvas,
          Offset(circleOffset.dx - (_data.circlePointerValue ?? 0) / 2,
              circleOffset.dy - (_data.circlePointerValue ?? 0) / 2));
    }
    canvas.save();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
