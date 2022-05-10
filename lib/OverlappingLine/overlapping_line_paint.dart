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

    final path = Path();
    path.moveTo(0, size.width * moveToCountList[0]);
    for (var i = 0; i <= moveToCountList.length - 1; i++) {
      path.lineTo(i * size.width, moveToCountList[i] * size.width);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
