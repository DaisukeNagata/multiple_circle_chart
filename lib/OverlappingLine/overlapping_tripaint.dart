import 'package:flutter/material.dart';

class OverlappingTriPaint extends CustomPainter {
  List<int> moveToCountList;
  double strokeWidth;
  OverlappingTriPaint(
      {required this.moveToCountList, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    path..moveTo(0, size.width * moveToCountList[0]);
    for (var i = 0; i <= moveToCountList.length - 1; i++) {
      path..lineTo(i * size.width, moveToCountList[i] * size.width);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
