import 'package:flutter/material.dart';

/// Logic to represent the graph
class OverlappingLinePaint extends CustomPainter {
  final List<int> moveToCountList;
  final double strokeWidth, scale, alphaPaint;
  final Color paintColor;
  final Shader? gradient;
  final bool circlePaintFlg, fillPaintFlg;
  final Animation<double> animation;

  const OverlappingLinePaint({
    required this.moveToCountList,
    required this.scale,
    required this.alphaPaint,
    required this.strokeWidth,
    required this.paintColor,
    required this.gradient,
    required this.circlePaintFlg,
    required this.fillPaintFlg,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    final path = Path();
    var count = moveToCountList.length - 1;

    ///　select the paint option.
    if (fillPaintFlg) {
      if (gradient == null) paint.color = paintColor.withOpacity(alphaPaint);
      paint.shader = gradient;
      path.moveTo(
        0,
        size.width * (moveToCountList.length - 1),
      );
    } else {
      if (gradient == null) paint.color = paintColor.withOpacity(alphaPaint);
      paint
        ..shader = gradient
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..shader = gradient;
      path.moveTo(
        0,
        size.width * moveToCountList[0],
      );
    }

    ///　Set the size from the element and array data.
    for (var i = 0; i <= moveToCountList.length - 1; i++) {
      if (fillPaintFlg) {
        /// Draw a line with lineTo.
        path.lineTo(
          i * size.width,
          size.width * count -
              (size.width * (moveToCountList[i] * animation.value)),
        );
      } else {
        /// Draw a line with lineTo.
        path.lineTo(
          i * size.width,
          moveToCountList[i] * size.width,
        );
      }

      /// Calculate the Z-axis and Y-axis of the graph.
      var rect = Rect.fromLTWH(
        i * size.width - strokeWidth / 2,
        moveToCountList[i] * size.width - strokeWidth / 2,
        strokeWidth,
        strokeWidth,
      );

      ///　Shows the pointer only when the flag is selected.
      if (circlePaintFlg) {
        ///　Representing a circle of graph points.
        final circlePaint = Paint()
          ..color = paintColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth * scale;

        ///　Construction of coordinate position.
        canvas.drawRect(rect, circlePaint);

        ///　Building a circle position
        canvas.drawCircle(
          rect.center,
          strokeWidth,
          circlePaint,
        );
      }
    }

    ///　Calculate line length.
    ///　-1 is an element starting from 0, so it matches the consistency.
    var value = (moveToCountList.length - 1);
    if (fillPaintFlg) path.lineTo(value * size.width, value * size.width);
    canvas.drawPath(path, paint);
    path.close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
