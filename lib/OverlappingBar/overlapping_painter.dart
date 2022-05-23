import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'overlapping_data.dart';

/// The OverlappingPainter class is a class that sets overlapping graphs.
class OverlappingPainter extends CustomPainter {
  OverlappingPainter({
    required this.widgetSize,
    required this.value,
    required this.graphCount,
    required this.contextSize,
    required this.offsetValue,
    required this.circleData,
    required this.radData,
    required this.backgroundColor,
    required this.textSpan,
    required this.dialogData,
    required this.controller,
  });

  final double? widgetSize;
  final double? value;
  final int? graphCount;
  final Size contextSize;
  final Offset offsetValue;
  final CircleData? circleData;
  final RadData? radData;
  final Color backgroundColor;
  final TextSpan? textSpan;
  final List<String>? dialogData;
  final StreamController<List<dynamic>> controller;

  /// Character arrangement according to height and width.
  void paintBar(Size size, Canvas canvas, TextSpan? span) {
    double degToRad(double deg) => deg * (pi / 180.0);
    final textSpan = span;
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    canvas.rotate(degToRad(radData == RadData.horizontal ? 360 : 90));
    textPainter.paint(canvas, offsetValue);
  }

  var count = -1;

  /// Class to publish when tapped.
  @override
  bool hitTest(Offset position) {
    switch (count) {
      case -1:
        List<dynamic> list = [];
        list.add(position);
        double answer = position.dx / (widgetSize ?? 0) / (graphCount ?? 0) * 100;
        list.add(dialogData?[answer.floor()]);
        controller.sink.add(list);
        break;
      case 2:
        count = 0;
        List<dynamic> list = [];
        list.add(position);
        double answer = position.dx / (widgetSize ?? 0) / (graphCount ?? 0) * 100;
        list.add(dialogData?[answer.floor()]);
        controller.sink.add(list);
        break;
    }
    count += 1;
    return true;
  }

  /// Method to set roundness
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(contextSize.width, 0.0);

    void drawBar(double x, double width) {
      final Paint paint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round;

      if (width <= 0) {
        return;
      }
      Rect rect = Rect.fromLTWH(0.0, 0.0, width, size.height);
      switch (circleData ?? CircleData.none) {
        case CircleData.none:
          canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              rect.right,
              rect.top,
              rect.left,
              rect.bottom,
              bottomRight: const Radius.circular(10),
              topRight: const Radius.circular(10),
            ),
            paint,
          );
          break;
        case CircleData.leftCircle:
          canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              rect.right,
              rect.top,
              rect.left,
              rect.bottom,
              bottomLeft: const Radius.circular(10),
              topLeft: const Radius.circular(10),
            ),
            paint,
          );
          break;
        case CircleData.rightCircle:
          canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              rect.right,
              rect.top,
              rect.left,
              rect.bottom,
              bottomRight: const Radius.circular(10),
              topRight: const Radius.circular(10),
            ),
            paint,
          );
          break;
        case CircleData.allCircle:
          canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              rect.right,
              rect.top,
              rect.left,
              rect.bottom,
              bottomLeft: const Radius.circular(10),
              topLeft: const Radius.circular(10),
              bottomRight: const Radius.circular(10),
              topRight: const Radius.circular(10),
            ),
            paint,
          );
          break;
      }
      paintBar(size, canvas, textSpan);
    }

    /// 0.0 ~ 1.0 * size.width　Range specification.
    if (value != null) {
      drawBar(0.0, (value?.clamp(0.0, 1.0) ?? 0.0) * size.width);
    } else {
      drawBar(0.0, size.width);
    }
  }

  /// Update the value as the color changes
  @override
  bool shouldRepaint(OverlappingPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor || oldDelegate.value != value;
  }
}
