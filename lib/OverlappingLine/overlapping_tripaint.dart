import 'package:flutter/material.dart';

class OverlappingTriPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (var i = 0; i <= 4; i++) {
      path
        ..moveTo(0, size.width * 4)
        ..lineTo(
          size.width * (i == 0 ? 0 : i),
          (i == 0 ? size.width * 4 : size.width * 4 - size.width * i),
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
