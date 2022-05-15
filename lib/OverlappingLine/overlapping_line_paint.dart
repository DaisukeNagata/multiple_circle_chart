import 'package:flutter/material.dart';

/// Logic to represent the graph
class OverlappingLinePaint extends CustomPainter {
  List<int> moveToCountList;
  double strokeWidth, scale = 1;
  Color paintColor;
  bool circlePaintFlg;
  OverlappingLinePaint(
      {required this.moveToCountList,
      required this.scale,
      required this.strokeWidth,
      required this.paintColor,
      required this.circlePaintFlg});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    path.moveTo(0, size.width * moveToCountList[0]);
    for (var i = 0; i <= moveToCountList.length - 1; i++) {
      path.lineTo(i * size.width, moveToCountList[i] * size.width);

      var rect = Rect.fromLTWH(
          i * size.width - strokeWidth / 2,
          moveToCountList[i] * size.width - strokeWidth / 2,
          strokeWidth,
          strokeWidth);
      if (circlePaintFlg) {
        ///　Representing a circle of graph points.
        final circlePaint = Paint()
          ..color = paintColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth * scale;

        ///　Construction of coordinate position.
        canvas.drawRect(rect, circlePaint);

        ///　Building a circle position
        canvas.drawCircle(rect.center, strokeWidth, circlePaint);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
