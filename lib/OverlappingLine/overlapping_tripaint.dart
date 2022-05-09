import 'package:flutter/material.dart';

class OverlappingTriPaint extends CustomPainter {
  int moveToCount;
  double strokeWidth;

  OverlappingTriPaint({required this.moveToCount, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (var i = 0; i <= moveToCount; i++) {
      path
        ..moveTo(0, size.width * moveToCount)
        ..lineTo(
          size.width * i,
          (i == 0
              ? size.width * moveToCount
              : size.width * moveToCount - size.width * i),
        );
    }
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
