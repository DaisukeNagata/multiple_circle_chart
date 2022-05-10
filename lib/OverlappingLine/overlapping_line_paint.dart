import 'package:flutter/material.dart';

class OverlappingLinePaint extends CustomPainter {
  List<int> moveToCountList;
  double strokeWidth;
  Color paintColor;
  OverlappingLinePaint(
      {required this.moveToCountList,
      required this.strokeWidth,
      required this.paintColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    /// TODO: Make it data logic.
    final circlePaint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 2;

    final path = Path();
    path.moveTo(0, size.width * moveToCountList[0]);
    for (var i = 0; i <= moveToCountList.length - 1; i++) {
      path.lineTo(i * size.width, moveToCountList[i] * size.width);

      var rect = Rect.fromLTWH(
          i * size.width - strokeWidth / 2,
          moveToCountList[i] * size.width - strokeWidth / 2,
          strokeWidth,
          strokeWidth);
      canvas.drawRect(rect, circlePaint);
      canvas.drawCircle(rect.center, strokeWidth, circlePaint);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
