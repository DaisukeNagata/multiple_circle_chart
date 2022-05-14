import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingLine/overlapping_goal_model.dart';

class OverlapinrLineGoalPaint extends CustomPainter {
  final double boxSize;
  final int wLines;
  final Size sizeSet;
  final OverlappingGoalModel goalModel;

  OverlapinrLineGoalPaint(
      {required this.boxSize,
      required this.wLines,
      required this.sizeSet,
      required this.goalModel});

  @override
  void paint(Canvas canvas, Size size) {
    double goalStartX = 0;
    final paint = Paint()
      ..color = goalModel.goalLineColor
      ..strokeWidth = goalModel.goalLineWidth;
    while (goalStartX < sizeSet.width) {
      canvas.drawLine(
          Offset(goalStartX, boxSize * (wLines - goalModel.goalLineValue)),
          Offset(goalStartX + goalModel.goalDashWidth,
              boxSize * (wLines - goalModel.goalLineValue)),
          paint);
      goalStartX += goalModel.goalLineWidth + goalModel.goalDashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
