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

      if (size.height * (_data.endValue?[i] ?? 0) * math.pi <
          textPainter.height + 2) {
        textSpan = TextSpan(children: <TextSpan>[
          TextSpan(
              text: '...',
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
