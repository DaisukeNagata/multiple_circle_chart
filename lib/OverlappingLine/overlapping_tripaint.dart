import 'package:flutter/material.dart';

class OverlappingTriPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (var i = 0; i <= 7; i++) {
      path
        ..moveTo(0, size.width * 7)
        ..lineTo(
          size.width * i,
          (i == 0 ? size.width * 7 : size.width * 7 - size.width * i),
        );
    }
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
