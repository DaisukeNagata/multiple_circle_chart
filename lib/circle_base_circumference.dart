import 'package:flutter/material.dart';

class CircleBaseCircumference extends CustomPainter {
  final List<Color> colors;
  final double strokeWidth;

  CircleBaseCircumference(this.colors, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(colors: colors).createShader(
          Rect.fromCircle(center: size.center(Offset.zero), radius: 0));
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
